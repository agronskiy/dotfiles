# FZF options
export FZF_DEFAULT_OPTS='--height 70% --reverse --border --bind=F2:toggle-preview'

# This makes `fzf-tab` completion more lightweight in general.
zstyle ':fzf-tab:*' fzf-flags --height 90% --reverse --no-border
# Git completion with preview on the right
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'git log --graph --color=always --abbrev-commit --decorate \
--format=format:\
"%C(bold blue)%h%C(reset) - \
%C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset) %C(dim white)- %an%C(reset)%n\
          %C(white)%s%C(reset) " \
$word'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
export FZF_DEFAULT_COMMAND='fd --hidden --follow --no-ignore --exclude .git'
export FZF_CTRL_T_COMMAND='fd --hidden --follow --no-ignore --exclude .git'

# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --no-ignore --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --no-ignore --exclude ".git" . "$1"
}
