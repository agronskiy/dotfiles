# FZF options
export FZF_DEFAULT_OPTS='--height 70% --reverse --border --bind=F2:toggle-preview,ctrl-u:preview-up,ctrl-d:preview-down'

#
# FZF-Tab options
#

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
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -TF -L=2 --color=always $realpath'
# preview on cat/bat (remember that here cat is aliased to bat)
zstyle ':fzf-tab:complete:(bat|cat):*' fzf-preview 'bat --color=always --plain $realpath'
zstyle ':completion:*:*:(bat|cat):*:*' file-patterns '*(-^/)'
# Completion for ssh
zstyle ':completion:*:ssh:*' hosts

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

# This updates the standard `**` completion
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'exa -TF -L=2 --color=always {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    cat|bat)      fzf "$@" --preview 'bat --color=always --plain {}' ;;
    *)            fzf "$@" ;;
  esac
}

_fzf_complete_cat() {
  _fzf_complete -- "$@" < <(
    fd --type f --hidden --follow --no-ignore --exclude .git .
  )
}

_fzf_complete_bat() {
  _fzf_complete -- "$@" < <(
    fd --type f --hidden --follow --no-ignore --exclude .git .
  )
}
