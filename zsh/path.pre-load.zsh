# Adds to path only if not yet sourced.
if [ ! -z "${ALREADY_SOURCED_ZSHRC+x}" ]; then
    return
fi

export PATH="$DOTFILES/bin:$PATH"

# Some Linux distros don't have `~/.local/bin`
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"

# This will account for standard Go installation path.
export PATH="$PATH:$HOME/go/bin"

# Rust if installed
export PATH="$PATH:$HOME/.cargo/bin"
