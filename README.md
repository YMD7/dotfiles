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
4. mise によるランタイム（Node.js, Python, Ruby）のインストール
5. Copilot.vim のクローン（未導入の場合）

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
| `~/.local/bin/tmux-ai-title` | `bin/tmux-ai-title`           |

## tmux AI タイトル

tmux のステータスライン右側に、現在の作業内容を AI が自動生成したタイトルとして表示する。

- **仕組み**: 3分おきにバックグラウンドで `claude` CLI (haiku) を呼び出し、ターミナルのコンテキスト（cwd、git 情報、画面内容、シェル履歴）からタイトルを生成
- **キャッシュ**: `~/.cache/tmux-ai-title/<セッション名>` にセッションごとに保存。ステータスライン表示時はキャッシュ読みのみなので遅延なし
- **前提**: `claude` CLI がインストールされていること
