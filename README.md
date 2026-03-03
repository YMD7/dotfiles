# dotfiles

## セットアップ

### 1. リポジトリをクローン

```sh
git clone https://github.com/Kyo/dotfiles.git ~/Dev/dotfiles
cd ~/Dev/dotfiles
```

### 2. Homebrew で依存パッケージをインストール

```sh
brew bundle
```

### 3. シンボリックリンクを作成

各設定ファイルのシンボリックリンクをホームディレクトリに作成する。

```sh
# 例
ln -sf ~/Dev/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/Dev/dotfiles/.gitconfig ~/.gitconfig
```

## シンボリックリンク一覧

| リンク元 (`~/...`)        | リンク先 (`dotfiles/...`)        |
| ------------------------- | -------------------------------- |
| `~/.zshrc`                | `.zshrc`                         |
| `~/.tmux.conf`            | `.tmux.conf`                     |
| `~/.gitconfig`            | `.gitconfig`                     |
| `~/.config/ghostty/`      | `.config/ghostty/`               |
| `~/.config/aerospace/`    | `.config/aerospace/`             |
| `~/.config/yazi/`         | `.config/yazi/`                  |
| `~/.config/sheldon/`      | `.config/sheldon/`               |
| `~/.config/starship.toml` | `.config/starship/starship.toml` |
| `~/.config/wezterm/`      | `.config/wezterm/`               |
| `~/.config/nvim/`         | `.config/nvim/`                  |
| `~/.config/zed/`          | `.config/zed/`                   |
| `~/.claude/CLAUDE.md`     | `.claude/CLAUDE.md`              |
| `~/.claude/skills/`       | `.claude/skills/`                |
| `~/.claude/statusline.sh` | `.claude/statusline.sh`          |
