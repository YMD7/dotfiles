alias ls='ls -G'
alias la='ls -Gla'
alias ll='ls -Gl'
alias dc='docker-compose'
alias dss='docker-sync-stack'
alias co='git checkout'

PS1="[%n@Local %~] "

eval "$(anyenv init -)"

# XDG base directory specification
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

