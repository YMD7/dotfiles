# .bash_profile

# Dropboxの中の.bashrcを参照する
source /Users/kyo-yamada/Dropbox/Personal/Dev/Dotfiles/.bashrc

# rbenvのパス
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
