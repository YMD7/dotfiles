alias ls='ls -G'
alias la='ls -Gla'
alias ll='ls -Gl'
alias dc='docker-compose'
alias dss='docker-sync-stack'
alias co='git checkout'

PS1="[%n@Local %~] "

# ssh agent
ssh-add --apple-use-keychain

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# pip2
export PATH="$PATH:/Users/kyo/Library/Python/2.7/bin"

# XDG base directory specification
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Flutter
export PATH="$PATH:$HOME/Dev/flutter/bin"
