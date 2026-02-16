# tmux auto-start on SSH
if [[ -n "$SSH_CONNECTION" ]] && command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
  tmux attach || tmux new
fi

# Aliases
alias ls='ls -G'
alias la='ls -Gla'
alias ll='ls -Gl'
alias dc='docker-compose'
alias dss='docker-sync-stack'
alias co='git checkout'
command -v opencode &>/dev/null && alias code='opencode'
command -v claude &>/dev/null && alias cc='claude --dangerously-skip-permissions'

# Prompt
PS1="[%n@Local %~] "

# XDG base directory specification
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# ssh agent (macOS)
command -v ssh-add &>/dev/null && ssh-add --apple-use-keychain 2>/dev/null

# Homebrew
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Volta
if [[ -d "$HOME/.volta" ]]; then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# anyenv
command -v anyenv &>/dev/null && eval "$(anyenv init -)"

# pip2
[[ -d "$HOME/Library/Python/2.7/bin" ]] && export PATH="$PATH:$HOME/Library/Python/2.7/bin"

# Flutter
[[ -d "$HOME/.local/share/flutter/bin" ]] && export PATH="$HOME/.local/share/flutter/bin:$PATH"

# Rust
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

# pnpm
if [[ -d "$HOME/.local/share/pnpm" ]]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

# opencode
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

# CodeRabbit CLI
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Prezto
[[ -f "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Bun
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# Kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && command -v kiro &>/dev/null && . "$(kiro --locate-shell-integration-path zsh)"

# direnv
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# WezTerm: Option + ← / → で単語移動
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
  bindkey '^[[1;3D' backward-word
  bindkey '^[[1;3C' forward-word
fi

# Terminal Startup Message
if command -v cowsay &>/dev/null && command -v lolcat &>/dev/null; then
  messages=(
    "Hello World!"
    "Moo!"
    "Meow!"
    "Beep Boop!"
    "まいど!"
    "Banana!"
    "!!!"
    "???"
    "Yay!"
    "Woohoo!"
    "Zzz...!"
    "Hi!"
    "Sup!"
  )

  animals=(
    "default"
    "small"
    "tux"
    "sheep"
    "elephant"
    "turkey"
    "stegosaurus"
    "fox"
    "cheese"
    "hellokitty"
    "moose"
    "turtle"
    "llama"
    "cupcake"
  )

  cowsay -f ${animals[$RANDOM % ${#animals[@]} + 1]} \
    "${messages[$RANDOM % ${#messages[@]} + 1]}" | lolcat
fi
