# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"

# FZF options
export FZF_DEFAULT_OPTS='--height 70% --reverse --border --bind=F2:toggle-preview'
