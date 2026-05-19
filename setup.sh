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
  ".vimrc                        : $HOME/.vimrc"
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
  ".codex/user-config.toml       : $HOME/.codex/config.toml"
  "LaunchAgents/com.ymd7.colima.plist : $HOME/Library/LaunchAgents/com.ymd7.colima.plist"
  "AGENTS.md                      : $HOME/CLAUDE.md"
  "AGENTS.md                      : $HOME/.codex/AGENTS.md"
  "AGENTS.md                      : $HOME/.gemini/GEMINI.md"
)

for entry in "${links[@]}"; do
  src="${entry%%:*}"
  src="${src// /}"
  dest="${entry##*:}"
  dest="${dest// /}"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$DOTFILES_DIR/$src" "$dest"
done

# ---------- 4. Colima LaunchAgent ----------
echo "Loading Colima LaunchAgent..."
COLIMA_AGENT_LABEL="com.ymd7.colima"
COLIMA_AGENT_PLIST="$HOME/Library/LaunchAgents/$COLIMA_AGENT_LABEL.plist"
COLIMA_AGENT_DOMAIN="gui/$(id -u)"
LEGACY_COLIMA_AGENT_LABEL="com.colima.default"
LEGACY_COLIMA_AGENT_PLIST="$HOME/Library/LaunchAgents/$LEGACY_COLIMA_AGENT_LABEL.plist"

if launchctl print "$COLIMA_AGENT_DOMAIN/$COLIMA_AGENT_LABEL" &>/dev/null; then
  launchctl bootout "$COLIMA_AGENT_DOMAIN/$COLIMA_AGENT_LABEL"
fi

if launchctl print "$COLIMA_AGENT_DOMAIN/$LEGACY_COLIMA_AGENT_LABEL" &>/dev/null; then
  launchctl bootout "$COLIMA_AGENT_DOMAIN/$LEGACY_COLIMA_AGENT_LABEL"
fi

if [ -e "$LEGACY_COLIMA_AGENT_PLIST" ]; then
  legacy_backup="$LEGACY_COLIMA_AGENT_PLIST.disabled.$(date +%Y%m%d%H%M%S)"
  mv "$LEGACY_COLIMA_AGENT_PLIST" "$legacy_backup"
  echo "Moved legacy Colima LaunchAgent to $legacy_backup"
fi

launchctl bootstrap "$COLIMA_AGENT_DOMAIN" "$COLIMA_AGENT_PLIST"
launchctl enable "$COLIMA_AGENT_DOMAIN/$COLIMA_AGENT_LABEL"

# ---------- 5. mise install ----------
echo "Installing runtimes via mise..."
eval "$("$HOMEBREW_PREFIX/bin/mise" activate bash)"
mise install

# ---------- 6. Neovim plugins ----------
COPILOT_DIR="$HOME/.config/nvim/pack/github/start/copilot.vim"
if [ ! -d "$COPILOT_DIR" ]; then
  echo "Cloning Copilot.vim..."
  mkdir -p "$(dirname "$COPILOT_DIR")"
  git clone https://github.com/github/copilot.vim.git "$COPILOT_DIR"
else
  echo "Copilot.vim already installed."
fi

# ---------- 7. Claude Code ----------
if ! command -v claude &>/dev/null; then
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "Claude Code already installed."
fi

# ---------- 8. Tailscale system daemon ----------
if [ ! -f /Library/LaunchDaemons/com.tailscale.tailscaled.plist ]; then
  echo ""
  read -p "Install tailscaled as a system daemon (recommended for non-server Macs)? [y/N] " answer
  if [[ "${answer:-N}" =~ ^[Yy]$ ]]; then
    sudo "$HOMEBREW_PREFIX/bin/tailscaled" install-system-daemon
    echo "Daemon installed. Run 'sudo tailscale up' to authenticate."
  fi
else
  echo "tailscaled system daemon already installed."
fi

# ---------- 9. Remote development (optional) ----------
echo ""
read -p "Set up this Mac as a remote dev machine (SSH/mosh)? [y/N] " answer
if [[ "${answer:-N}" =~ ^[Yy]$ ]]; then
  bash "$DOTFILES_DIR/setup-remote-dev.sh"
fi

echo "Done!"
