# FZF options
export FZF_DEFAULT_OPTS='--height 70% --reverse --border --bind=F2:toggle-preview'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git'

# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
