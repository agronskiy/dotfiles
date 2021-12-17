# Based on https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236s

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

export CURR_DELTA_COMMAND='delta --line-numbers \
    --minus-style '\''red'\'' --minus-emph-style '\''red 52'\'' \
    --zero-style '\''normal'\'' \
    --plus-style '\''green'\'' --plus-emph-style '\''green 22'\'' \
    --hunk-header-line-number-style '\''magenta'\'' \
    --hunk-header-style '\''bold file line-number syntax'\'' --hunk-header-decoration-style '\''ul ol'\'' \
    --file-style '\''omit'\'' --file-decoration-style '\''omit'\'' \
    --commit-style '\''bold yellow'\'' '

_git-files-fuzzy() {
  is_in_git_repo || return
  if [ -z "$1" ]; then
    commit_minus=""
    commit_plus=""
    status_command=(git -c color.status=always status --short )
    filter_command=cat
  else
    commit_minus="$1"
    if [ -z "$2" ]; then
      commit_plus="HEAD"
    else
      commit_plus="$2"
    fi
    status_command=(git diff --name-status $commit_minus $commit_plus )
    filter_command=(tr '\t' ' ')
  fi
  delta_command=
  preview_command="git diff $commit_minus $commit_plus "'{-1} | '"$CURR_DELTA_COMMAND"


  ${status_command[@]} |
  $filter_command |
    FZF_TMUX_OPTS="$FZF_TMUX_OPTS -p 95%,95%" \
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 90%" \
  fzf-tmux $FZF_TMUX_OPTS -m --ansi --nth 2.. \
    --preview-window wrap:right:80% \
    --preview "$preview_command" |
  awk '{print $2}' | sed 's/.* -> //'

}
alias gss=_git-files-fuzzy
compdef _git _git-files-fuzzy=git-diff

_git-checkout-local-branches-fuzzy() {
  is_in_git_repo || return
  chosen_branch=$(git branch --color=always | grep -v '/HEAD\s' | sort |
  fzf-tmux $FZF_TMUX_OPTS --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --graph --color=always --abbrev-commit --decorate \
--format=format:\
"%C(bold blue)%h%C(reset) - \
%C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset) %C(dim white)- %an%C(reset)%n\
          %C(white)%s%C(reset) " $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##' | tr '\n' ' ' )

  if [ ! -z "$chosen_branch" ] ; then
    curr_cmd="git checkout $chosen_branch"
    print -z -- $curr_cmd
  fi
}
alias gcol=_git-checkout-local-branches-fuzzy

_git-tag-fuzzy() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-tmux $FZF_TMUX_OPTS --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

_git-history-fuzzy() {
  is_in_git_repo || return

  glog --color=always |
    FZF_TMUX_OPTS="$FZF_TMUX_OPTS -p 95%,95%" \
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 90%" \
  fzf-tmux $FZF_TMUX_OPTS --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort, CTRL-/ for diff preview ' \
    --preview-window hidden:wrap:right:80% \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | (xargs git show | '$CURR_DELTA_COMMAND') ' |
  grep -o "[a-f0-9]\{7,\}" |
  tr '\n' ' '
}
alias glogg="_git-history-fuzzy"

_git-stash-fuzzy() {
  is_in_git_repo || return
  git stash list | fzf-tmux $FZF_TMUX_OPTS --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

