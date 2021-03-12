# Adds to path only if not yet sourced.
if [ ! -z "${ALREADY_SOURCED_ZSHRC+x}" ]; then
    return
fi

export PATH="/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"

