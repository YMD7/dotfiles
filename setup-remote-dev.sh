#!/usr/bin/env bash
set -euo pipefail

HOMEBREW_PREFIX="/opt/homebrew"
MOSH_SERVER="$HOMEBREW_PREFIX/bin/mosh-server"
FIREWALL_CMD="/usr/libexec/ApplicationFirewall/socketfilterfw"

# ---------- 1. Sudo ----------
echo "This script requires administrator privileges."
sudo -v

# バックグラウンドで sudo タイムスタンプを維持
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_PID=$!
trap 'kill "$SUDO_PID" 2>/dev/null' EXIT

# ---------- 2. SSH (Remote Login) ----------
echo "Configuring SSH..."
remote_login=$(sudo systemsetup -getremotelogin)
if echo "$remote_login" | grep -qi "off"; then
  sudo systemsetup -f -setremotelogin on
  echo "Remote Login enabled."
else
  echo "Remote Login already enabled."
fi

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
echo "Configuring Cloudflare Tunnel..."
if command -v cloudflared &>/dev/null; then
  if [ -f "$HOME/.cloudflared/config.yml" ]; then
    sudo cloudflared service install
    echo "Cloudflare Tunnel service installed."
  else
    echo "Warning: ~/.cloudflared/config.yml not found."
    echo "Run 'cloudflared tunnel login' and create a tunnel first."
    echo "See README.md for manual setup steps."
  fi
else
  echo "Warning: cloudflared not found — skipping tunnel setup."
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
fi
echo ""
echo "--- Power Management ---"
pmset -g | grep -E "sleep|displaysleep|disablesleep|womp|powernap|tcpkeepalive|hibernatemode"

# ---------- 7. Done ----------
echo ""
echo "Remote development setup complete."
echo "Connect via:"
echo "  ssh $(hostname).local"
echo "  mosh $(hostname).local"
echo ""
echo "Note: mosh uses UDP 60000-61000. If using a network router/firewall,"
echo "ensure these ports are forwarded."
