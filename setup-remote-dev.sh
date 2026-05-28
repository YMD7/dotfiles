#!/usr/bin/env bash
set -euo pipefail

HOMEBREW_PREFIX="/opt/homebrew"
MOSH_SERVER="$HOMEBREW_PREFIX/bin/mosh-server"
FIREWALL_CMD="/usr/libexec/ApplicationFirewall/socketfilterfw"
FULL_DISK_ACCESS_PANE="x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"

prompt_full_disk_access() {
  echo ""
  echo "Remote Login の有効化に失敗しました。"
  echo "macOS の権限仕様により、実行中のターミナルアプリにフルディスクアクセスが必要です。"
  echo ""
  echo "これからフルディスクアクセスの設定画面を開きます。"
  echo "開かない場合は、次の場所を手動で開いてください。"
  echo "  システム設定 > プライバシーとセキュリティ > フルディスクアクセス"
  echo ""
  echo "手順:"
  echo "  (1) このスクリプトを実行しているターミナルアプリを追加または有効化する"
  echo "      例: Terminal / iTerm2 / Ghostty / WezTerm"
  echo "  (2) 必要に応じてターミナルアプリを再起動する"
  echo "  (3) この画面に戻り、再試行する場合は y を押す"
  echo ""

  if ! open "$FULL_DISK_ACCESS_PANE"; then
    echo "Warning: フルディスクアクセスの設定画面を自動で開けませんでした。"
  fi

  while true; do
    read -r -p "フルディスクアクセスの設定が完了しましたか？再試行する場合は y、終了する場合は n を押してください。 [y/N] " answer
    case "${answer:-N}" in
      [Yy])
        return 0
        ;;
      [Nn])
        echo "Remote Login の有効化を中断しました。設定後に setup-remote-dev.sh を再実行してください。"
        exit 1
        ;;
      *)
        echo "y または n を入力してください。"
        ;;
    esac
  done
}

enable_remote_login() {
  while true; do
    remote_login=$(sudo systemsetup -getremotelogin 2>&1) || {
      echo "$remote_login"
      prompt_full_disk_access
      continue
    }

    if ! echo "$remote_login" | grep -qi "off"; then
      echo "Remote Login already enabled."
      return 0
    fi

    set_remote_login_output=$(sudo systemsetup -f -setremotelogin on 2>&1) && {
      echo "Remote Login enabled."
      return 0
    }

    echo "$set_remote_login_output"
    prompt_full_disk_access
  done
}

get_local_hostname() {
  local host

  host=$(hostname)
  if [[ "$host" == *.local ]]; then
    echo "$host"
  else
    echo "$host.local"
  fi
}

# ---------- 1. Sudo ----------
echo "This script requires administrator privileges."
sudo -v

# バックグラウンドで sudo タイムスタンプを維持
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_PID=$!
trap 'kill "$SUDO_PID" 2>/dev/null' EXIT

# ---------- 2. SSH (Remote Login) ----------
echo "Configuring SSH..."
enable_remote_login

# ---------- 3. Firewall - allow mosh-server ----------
echo "Configuring firewall for mosh..."
if [ -x "$MOSH_SERVER" ]; then
  sudo "$FIREWALL_CMD" --add "$MOSH_SERVER"
  sudo "$FIREWALL_CMD" --unblockapp "$MOSH_SERVER"
  echo "mosh-server allowed through firewall."
else
  echo "Warning: mosh-server not found at $MOSH_SERVER — skipping firewall config."
fi

# ---------- 4. Cloudflare Tunnel ----------
# cloudflared service install が生成する LaunchDaemon の plist には
# tunnel run サブコマンドや --config パスが含まれないため、
# サービス登録後に plist を修正して正しい引数を設定する。
#
# 前提: cloudflared tunnel login / create / route dns を事前に実行済みであること。
#       ~/.cloudflared/config.yml にトンネル設定が記載されていること。
#       手順は README.md の「Cloudflare Tunnel」セクションを参照。
CLOUDFLARED_PLIST="/Library/LaunchDaemons/com.cloudflare.cloudflared.plist"
CLOUDFLARED_CONFIG="$HOME/.cloudflared/config.yml"

echo "Configuring Cloudflare Tunnel..."
if ! command -v cloudflared &>/dev/null; then
  echo "Warning: cloudflared not found — skipping tunnel setup."
elif [ ! -f "$CLOUDFLARED_CONFIG" ]; then
  echo "Warning: $CLOUDFLARED_CONFIG not found."
  echo "Run 'cloudflared tunnel login' and create a tunnel first."
  echo "See README.md for manual setup steps."
elif [ -f "$CLOUDFLARED_PLIST" ]; then
  echo "Cloudflare Tunnel service already installed."
else
  sudo cloudflared service install

  # plist を修正: tunnel run --config <path> を引数に追加
  sudo /usr/libexec/PlistBuddy -c "Delete :ProgramArguments" "$CLOUDFLARED_PLIST"
  sudo /usr/libexec/PlistBuddy -c "Add :ProgramArguments array" "$CLOUDFLARED_PLIST"
  sudo /usr/libexec/PlistBuddy -c "Add :ProgramArguments:0 string /opt/homebrew/bin/cloudflared" "$CLOUDFLARED_PLIST"
  sudo /usr/libexec/PlistBuddy -c "Add :ProgramArguments:1 string tunnel" "$CLOUDFLARED_PLIST"
  sudo /usr/libexec/PlistBuddy -c "Add :ProgramArguments:2 string --config" "$CLOUDFLARED_PLIST"
  sudo /usr/libexec/PlistBuddy -c "Add :ProgramArguments:3 string $CLOUDFLARED_CONFIG" "$CLOUDFLARED_PLIST"
  sudo /usr/libexec/PlistBuddy -c "Add :ProgramArguments:4 string run" "$CLOUDFLARED_PLIST"

  sudo launchctl unload "$CLOUDFLARED_PLIST"
  sudo launchctl load "$CLOUDFLARED_PLIST"
  echo "Cloudflare Tunnel service installed and configured."
fi

# ---------- 5. Power management ----------
echo "Configuring power management..."
sudo pmset -a sleep 0
sudo pmset -a disablesleep 1
sudo pmset -a displaysleep 10
sudo pmset -a womp 1
sudo pmset -a powernap 0
sudo pmset -a tcpkeepalive 1
sudo pmset -a hibernatemode 0
echo "Power management configured."

# ---------- 6. Verification ----------
echo ""
echo "=== Verification ==="
echo ""
echo "--- Remote Login ---"
sudo systemsetup -getremotelogin
echo ""
echo "--- Firewall (mosh-server) ---"
if [ -x "$MOSH_SERVER" ]; then
  sudo "$FIREWALL_CMD" --getappblocked "$MOSH_SERVER"
fi
echo ""
echo "--- Cloudflare Tunnel ---"
if command -v cloudflared &>/dev/null; then
  sudo launchctl list | grep cloudflared || echo "Service not registered"
  if [ -f "$CLOUDFLARED_PLIST" ]; then
    echo "Config path: $(/usr/libexec/PlistBuddy -c "Print :ProgramArguments:3" "$CLOUDFLARED_PLIST" 2>/dev/null || echo "not set")"
  fi
fi
echo ""
echo "--- Power Management ---"
pmset -g | grep -E "sleep|displaysleep|disablesleep|womp|powernap|tcpkeepalive|hibernatemode"

# ---------- 7. Done ----------
remote_host=$(get_local_hostname)

echo ""
echo "Remote development setup complete."
echo "Connect via:"
echo "  ssh $remote_host"
echo "  mosh $remote_host"
echo ""
echo "Note: mosh uses UDP 60000-61000. If using a network router/firewall,"
echo "ensure these ports are forwarded."
