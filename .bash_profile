# .bashrcの参照
source ~/.bashrc

# rbenvのパス
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
