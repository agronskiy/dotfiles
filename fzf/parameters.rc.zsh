# FZF options
export FZF_DEFAULT_OPTS='--height 70% --reverse '\
'--bind=f2:toggle-preview,'\
'page-up:preview-half-page-up,'\
'page-down:preview-half-page-down,'\
'alt-up:preview-up,'\
'alt-down:preview-down,'\
'alt-g:preview-top,'\
'alt-G:preview-bottom'

export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 85%,85%"

#
# FZF-Tab options
#

__fzf_tab_autocompletion_command() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux" || echo "fzf"
}

__fzf_tab_autocompletion_flags() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} " || echo "--height 90% --reverse --no-border "
}

# This makes `fzf-tab` completion more lightweight in general.
zstyle ':fzf-tab:*' fzf-command $(__fzf_tab_autocompletion_command)
zstyle ':fzf-tab:*' fzf-flags $(__fzf_tab_autocompletion_flags)

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

# preview on cat/bat/vim/nvim (remember that here cat is aliased to bat)
zstyle ':fzf-tab:complete:(bat|cat|vim|nvim):*' fzf-preview 'bat --color=always --plain $realpath'

# NOTE: uncomment below to exclude directories from autocompletion. Usefulness is questionable
# because we can still want to navigate to the subdirectory.
# zstyle ':completion:*:*:(bat|cat|vim|nvim):*:*' file-patterns '*(-^/)'

# Completion for ssh
zstyle ':completion:*:ssh:*' hosts

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

# This updates the standard `**` completion
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           $(__fzfcmd) "$@" --preview 'exa -TF -L=2 --color=always {} | head -200' ;;
    export|unset) $(__fzfcmd) "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          $(__fzfcmd) "$@" --preview 'dig {}' ;;
    cat|bat|vim|nvim)  $(__fzfcmd) "$@" --preview 'bat --color=always --plain {}' ;;
    *)            $(__fzfcmd) "$@" ;;
  esac
}

# See `completion-utils.zsh`
_fzf_complete_cat() {
  __custom_fzf_file_path_completion "$prefix" "$1"
}

# See `completion-utils.zsh`
_fzf_complete_bat() {
  __custom_fzf_file_path_completion "$prefix" "$1"
}
