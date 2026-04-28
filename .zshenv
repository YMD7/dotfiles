# Homebrew
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Codex CLI dev API key (separated from project OPENAI_API_KEY via macOS Keychain)
export CODEX_API_KEY="$(security find-generic-password -a kyo -s codex-cli -w 2>/dev/null)"
