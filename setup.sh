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

# ---------- 3.1. SSH key ----------
echo "Checking SSH key..."
SSH_DIR="$HOME/.ssh"
SSH_KEY="$SSH_DIR/id_ed25519"
SSH_KEY_DISPLAY="~/.ssh/id_ed25519"

print_ssh_config_template() {
  cat <<EOF
Add a host entry like this to $SSH_DIR/config when you want to use this key:

Host <alias>
  HostName <hostname-or-tailscale-ip>
  User <remote-user>
  IdentityFile $SSH_KEY_DISPLAY
  AddKeysToAgent yes
  UseKeychain yes

Example:

Host ymd
  HostName 100.103.17.105
  User kyo
  IdentityFile $SSH_KEY_DISPLAY
  AddKeysToAgent yes
  UseKeychain yes
EOF
  echo ""
}

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ -f "$SSH_KEY" ] && [ -f "$SSH_KEY.pub" ]; then
  echo "SSH key already exists: $SSH_KEY"
  print_ssh_config_template
elif [ -e "$SSH_KEY" ] || [ -e "$SSH_KEY.pub" ]; then
  echo "WARNING: SSH key files are incomplete."
  echo "Expected both files:"
  echo "  $SSH_KEY"
  echo "  $SSH_KEY.pub"
  echo "Skipping SSH key generation to avoid overwriting existing files."
else
  echo "SSH key not found: $SSH_KEY"
  read -p "Create a new ed25519 SSH key for this machine? [y/N] " answer
  if [[ "${answer:-N}" =~ ^[Yy]$ ]]; then
    ssh-keygen -t ed25519 -f "$SSH_KEY" -C "$(whoami)@$(hostname)" -N ""
    chmod 600 "$SSH_KEY"
    chmod 644 "$SSH_KEY.pub"
    echo "SSH key created: $SSH_KEY"
    echo "Register this public key on remote machines when you want passwordless SSH:"
    echo "  $SSH_KEY.pub"
    print_ssh_config_template
  else
    echo "Skipping SSH key generation."
  fi
fi

# ---------- 3.5. Codex config.toml (template-merge) ----------
# シムリンクではなく、~/.codex/config.toml の管理ブロックだけを
# .codex/config.toml.template の内容で差し替える方式。
# 管理ブロック外（ルート直下のキー / [projects.*] / [hooks.state.*] 等）は温存する。
echo "Syncing Codex shared config block..."
CODEX_TEMPLATE="$DOTFILES_DIR/.codex/config.toml.template"
CODEX_TARGET="$HOME/.codex/config.toml"
CODEX_BEGIN="# >>> dotfiles:codex-shared (managed — do not edit between markers) >>>"
CODEX_END="# <<< dotfiles:codex-shared <<<"

mkdir -p "$(dirname "$CODEX_TARGET")"

if [ ! -e "$CODEX_TARGET" ]; then
  echo "  Initializing $CODEX_TARGET from template."
  {
    echo "$CODEX_BEGIN"
    cat "$CODEX_TEMPLATE"
    echo "$CODEX_END"
  } > "$CODEX_TARGET"
elif grep -qF "$CODEX_BEGIN" "$CODEX_TARGET" && grep -qF "$CODEX_END" "$CODEX_TARGET"; then
  echo "  Updating managed block in $CODEX_TARGET."
  codex_tmp="$(mktemp)"
  awk -v begin="$CODEX_BEGIN" -v end="$CODEX_END" -v tplfile="$CODEX_TEMPLATE" '
    BEGIN { inblock = 0 }
    {
      if (!inblock && index($0, begin) == 1) {
        print begin
        while ((getline line < tplfile) > 0) print line
        close(tplfile)
        inblock = 1
        next
      }
      if (inblock && index($0, end) == 1) {
        print end
        inblock = 0
        next
      }
      if (!inblock) print
    }
  ' "$CODEX_TARGET" > "$codex_tmp"
  mv "$codex_tmp" "$CODEX_TARGET"
else
  echo ""
  echo "  WARNING: $CODEX_TARGET exists without dotfiles markers."
  echo "  Wrap the template block manually:"
  echo "    $CODEX_BEGIN"
  echo "    ... insert contents of $CODEX_TEMPLATE ..."
  echo "    $CODEX_END"
  echo "  After that, re-run setup.sh to enable automated updates."
  echo "  (Skipping Codex config sync this run.)"
fi

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
