# ==============================================================================
# .zshrc
# ==============================================================================

# --- tmux auto-start on SSH ---------------------------------------------------
if [[ -n "$SSH_CONNECTION" ]] && command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
  tmux attach || tmux new
fi

# --- XDG base directory -------------------------------------------------------
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# --- Homebrew -----------------------------------------------------------------
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# --- Completion ---------------------------------------------------------------
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'       # case-insensitive
zstyle ':completion:*' menu select                          # arrow-key menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # colorized

# --- sheldon (plugin manager) -------------------------------------------------
if command -v sheldon &>/dev/null; then
  eval "$(sheldon source)"
fi

# --- Starship (prompt) --------------------------------------------------------
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# --- mise (runtime version manager) -------------------------------------------
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

# --- Rust ---------------------------------------------------------------------
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

# --- pnpm ---------------------------------------------------------------------
if [[ -d "$HOME/.local/share/pnpm" ]]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

# --- Local bin ----------------------------------------------------------------
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# --- Bun ----------------------------------------------------------------------
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# --- ssh agent (macOS) --------------------------------------------------------
command -v ssh-add &>/dev/null && ssh-add --apple-use-keychain 2>/dev/null

# --- direnv -------------------------------------------------------------------
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# --- Aliases ------------------------------------------------------------------
alias ls='ls -G'
alias la='ls -Gla'
alias ll='ls -Gl'
alias co='git checkout'
command -v opencode &>/dev/null && alias code='opencode'
command -v claude &>/dev/null && alias cc='claude --dangerously-skip-permissions'

# --- opencode -----------------------------------------------------------------
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

# --- Kiro ---------------------------------------------------------------------
[[ "$TERM_PROGRAM" == "kiro" ]] && command -v kiro &>/dev/null && \
  . "$(kiro --locate-shell-integration-path zsh)"

# --- WezTerm: Option + arrow word navigation ----------------------------------
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
  bindkey '^[[1;3D' backward-word
  bindkey '^[[1;3C' forward-word
fi

# --- Startup message ----------------------------------------------------------
if command -v cowsay &>/dev/null && command -v lolcat &>/dev/null; then
  messages=(
    "Hello World!" "Moo!" "Meow!" "Beep Boop!" "まいど!" "Banana!"
    "!!!" "???" "Yay!" "Woohoo!" "Zzz...!" "Hi!" "Sup!"
  )
  animals=(
    "default" "small" "tux" "sheep" "elephant" "turkey" "stegosaurus"
    "fox" "cheese" "hellokitty" "moose" "turtle" "llama" "cupcake"
  )
  cowsay -f ${animals[$RANDOM % ${#animals[@]} + 1]} \
    "${messages[$RANDOM % ${#messages[@]} + 1]}" | lolcat
fi
