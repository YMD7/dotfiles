alias ls='ls -G'
alias la='ls -Gla'
alias ll='ls -Gl'
alias dc='docker-compose'
alias dss='docker-sync-stack'
alias co='git checkout'
alias code='opencode'

PS1="[%n@Local %~] "

# ssh agent
ssh-add --apple-use-keychain

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# anyenv
eval "$(anyenv init -)"

# pip2
export PATH="$PATH:/Users/kyo/Library/Python/2.7/bin"

# XDG base directory specification
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Flutter
export PATH="$HOME/.local/share/flutter/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"


# Added by Windsurf
export PATH="/Users/Kyo/.codeium/windsurf/bin:$PATH"

# Prezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# pnpm
export PNPM_HOME="/Users/Kyo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.local/share/../bin/env"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# opencode
export PATH=/Users/Kyo/.opencode/bin:$PATH

# Added by CodeRabbit CLI installer
export PATH="/Users/Kyo/.local/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# Terminal Startup Message
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
