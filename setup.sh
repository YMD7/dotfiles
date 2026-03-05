#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/Dev/dotfiles"
HOMEBREW_PREFIX="/opt/homebrew"

# ---------- 1. Homebrew ----------
if [ ! -x "$HOMEBREW_PREFIX/bin/brew" ]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ---------- 2. brew bundle ----------
echo "Running brew bundle..."
"$HOMEBREW_PREFIX/bin/brew" bundle --file="$DOTFILES_DIR/Brewfile"

# ---------- 3. Symlinks ----------
echo "Creating symlinks..."

declare -a links=(
  # source (dotfiles)            : target (home)
  ".zshenv                       : $HOME/.zshenv"
  ".zshrc                        : $HOME/.zshrc"
  ".tmux.conf                    : $HOME/.tmux.conf"
  ".gitconfig                    : $HOME/.gitconfig"
  ".config/ghostty               : $HOME/.config/ghostty"
  ".config/aerospace             : $HOME/.config/aerospace"
  ".config/yazi                  : $HOME/.config/yazi"
  ".config/sheldon               : $HOME/.config/sheldon"
  ".config/starship              : $HOME/.config/starship"
  ".config/wezterm               : $HOME/.config/wezterm"
  ".config/nvim                  : $HOME/.config/nvim"
  ".config/zed                   : $HOME/.config/zed"
  ".config/mise                  : $HOME/.config/mise"
  ".claude/skills                : $HOME/.claude/skills"
  ".claude/settings.json         : $HOME/.claude/settings.json"
  ".claude/statusline.sh         : $HOME/.claude/statusline.sh"
  "bin/tmux-ai-title             : $HOME/.local/bin/tmux-ai-title"
)

for entry in "${links[@]}"; do
  src="${entry%%:*}"
  src="${src// /}"
  dest="${entry##*:}"
  dest="${dest// /}"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$DOTFILES_DIR/$src" "$dest"
done

# ---------- 4. mise install ----------
echo "Installing runtimes via mise..."
eval "$("$HOMEBREW_PREFIX/bin/mise" activate bash)"
mise install

# ---------- 5. Neovim plugins ----------
COPILOT_DIR="$HOME/.config/nvim/pack/github/start/copilot.vim"
if [ ! -d "$COPILOT_DIR" ]; then
  echo "Cloning Copilot.vim..."
  mkdir -p "$(dirname "$COPILOT_DIR")"
  git clone https://github.com/github/copilot.vim.git "$COPILOT_DIR"
else
  echo "Copilot.vim already installed."
fi

echo "Done!"
