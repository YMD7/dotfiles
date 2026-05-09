# dotfiles

## セットアップ

### 1. リポジトリをクローン

```sh
git clone https://github.com/YMD7/dotfiles.git ~/Dev/dotfiles
cd ~/Dev/dotfiles
```

### 2. セットアップスクリプトを実行

```sh
bash setup.sh
```

以下が自動で行われる:

1. Homebrew のインストール（未導入の場合）
2. `brew bundle` で依存パッケージをインストール
3. シンボリックリンクの一括作成
4. Colima LaunchAgent の登録
5. mise によるランタイム（Node.js, Python, Ruby）のインストール
6. Copilot.vim のクローン（未導入の場合）

## シンボリックリンク一覧

| リンク元 (`~/...`)        | リンク先 (`dotfiles/...`)        |
| ------------------------- | -------------------------------- |
| `~/.zshenv`               | `.zshenv`                        |
| `~/.zshrc`                | `.zshrc`                         |
| `~/.tmux.conf`            | `.tmux.conf`                     |
| `~/.gitconfig`            | `.gitconfig`                     |
| `~/.config/ghostty/`      | `.config/ghostty/`               |
| `~/.config/aerospace/`    | `.config/aerospace/`             |
| `~/.config/yazi/`         | `.config/yazi/`                  |
| `~/.config/sheldon/`      | `.config/sheldon/`               |
| `~/.config/starship/`     | `.config/starship/`              |
| `~/.config/wezterm/`      | `.config/wezterm/`               |
| `~/.config/nvim/`         | `.config/nvim/`                  |
| `~/.config/zed/`          | `.config/zed/`                   |
| `~/.config/mise/`         | `.config/mise/`                  |
| `~/.claude/skills/`       | `.claude/skills/`                |
| `~/.claude/settings.json` | `.claude/settings.json`          |
| `~/.claude/statusline.sh` | `.claude/statusline.sh`          |
| `~/Library/LaunchAgents/com.ymd7.colima.plist` | `LaunchAgents/com.ymd7.colima.plist` |

## Container (colima)

`colima` と `docker` CLI は Brewfile で導入される。`setup.sh` は LaunchAgent を登録し、ログイン時に Colima を自動起動する:

```sh
launchctl print gui/$(id -u)/com.ymd7.colima
```

LaunchAgent は以下の設定で `colima start` を実行する:

```sh
colima start --cpu 4 --memory 8 --disk 100
```

リソース割り当ては `LaunchAgents/com.ymd7.colima.plist` を編集して調整する。停止は `colima stop`、設定変更は再起動が必要。

## Cloudflare Tunnel（リモートアクセス）

`setup-remote-dev.sh` でサービス登録まで自動化されるが、初回はトンネルの作成と Cloudflare Access の設定が必要。

### 事前準備: トンネル作成

```sh
# Cloudflare 認証（ブラウザが開く）
cloudflared tunnel login

# トンネル作成
cloudflared tunnel create <トンネル名>

# DNS レコード設定
cloudflared tunnel route dns <トンネル名> ssh.<ドメイン名>
```

### 設定ファイル作成

`~/.cloudflared/config.yml`:

```yaml
tunnel: <トンネルID>
credentials-file: ~/.cloudflared/<トンネルID>.json

ingress:
  - hostname: ssh.<ドメイン名>
    service: ssh://localhost:22
  - service: http_status:404
```

### Cloudflare Access 設定（Zero Trust ダッシュボード）

https://one.dash.cloudflare.com で以下を設定:

1. **認証プロバイダ追加**: Settings > Authentication > Login methods > Google
2. **アプリケーション作成**: Access > Applications > Add > Self-hosted
   - Domain: `ssh.<ドメイン名>`
   - Policy: Allow / Emails で自分のメールアドレスのみ許可
   - Browser rendering: **SSH**

設定後、ブラウザで `https://ssh.<ドメイン名>` にアクセスすると、Google 認証を経てブラウザ上で SSH ターミナルが使える。

## Tailscale（VPN）

MacBook 等の実機では **`tailscaled` daemon モード** で稼働させる。macOS GUI 版（App Store / Standalone）はコンソールユーザーのログアウト判定（画面ロック・Fast User Switching 等）に追従して停止してしまうため、家族と PC 共有する用途では実用に耐えん。daemon は root LaunchDaemon として動くんで、ユーザーセッションに依存せず常時稼働する。

### 初回セットアップ

```sh
# 1. CLI と daemon バイナリを導入（Brewfile 経由）
brew install tailscale

# 2. （GUI 版が入ってる場合）アンインストール
#    - Finder で /Applications/Tailscale.app をゴミ箱へ
#    - System Settings > VPN から Tailscale プロファイルを削除
#    - System Settings > General > Login Items から Tailscale を外す

# 3. システム daemon として登録（root 権限必要）
sudo tailscaled install-system-daemon
# /Library/LaunchDaemons/com.tailscale.tailscaled.plist が作られ、即座に起動する

# 4. ログイン認証（標準出力に出る URL をブラウザで開いて認証）
sudo tailscale up
```

### 日常操作

```sh
tailscale status              # 接続状態（peer 一覧）
tailscale ip                  # 自分の Tailscale IP
sudo tailscale up             # 接続開始
sudo tailscale down           # 切断（daemon は起動継続）
sudo tailscale logout         # 完全ログアウト（再認証必要）
tailscale ping <peer>         # peer への到達確認
tailscale netcheck            # NAT・DERP 経路診断
```

### daemon 管理

```sh
# 状態確認
sudo launchctl print system/com.tailscale.tailscaled | head

# 再起動（設定変更後など）
sudo launchctl kickstart -k system/com.tailscale.tailscaled

# アンインストール
sudo tailscaled uninstall-system-daemon
```

### アップデート

```sh
brew upgrade tailscale
sudo launchctl kickstart -k system/com.tailscale.tailscaled
```
