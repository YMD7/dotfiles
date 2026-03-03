# dotfiles

## セットアップ

### 1. リポジトリをクローン

```sh
git clone https://github.com/YMD7/dotfiles.git ~/Dev/dotfiles
cd ~/Dev/dotfiles
```

### 2. Homebrew で依存パッケージをインストール

```sh
brew bundle
```

### 3. シンボリックリンクを作成

各設定ファイルのシンボリックリンクをホームディレクトリに作成する。

```sh
ln -sf ~/Dev/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/Dev/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config ~/.claude
ln -sf ~/Dev/dotfiles/.config/ghostty ~/.config/ghostty
ln -sf ~/Dev/dotfiles/.config/aerospace ~/.config/aerospace
ln -sf ~/Dev/dotfiles/.config/yazi ~/.config/yazi
ln -sf ~/Dev/dotfiles/.config/sheldon ~/.config/sheldon
ln -sf ~/Dev/dotfiles/.config/starship/starship.toml ~/.config/starship.toml
ln -sf ~/Dev/dotfiles/.config/wezterm ~/.config/wezterm
ln -sf ~/Dev/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/Dev/dotfiles/.config/zed ~/.config/zed
ln -sf ~/Dev/dotfiles/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/Dev/dotfiles/.claude/skills ~/.claude/skills
ln -sf ~/Dev/dotfiles/.claude/statusline.sh ~/.claude/statusline.sh
```

### 4. Neovim プラグインのインストール

Copilot.vim は `pack/` に手動インストールする（リポジトリには含まれていない）。

```sh
git clone https://github.com/github/copilot.vim.git \
  ~/.config/nvim/pack/github/start/copilot.vim
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
