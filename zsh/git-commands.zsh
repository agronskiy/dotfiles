# Based on https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236s

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

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
  delta_command='delta --keep-plus-minus-markers \
      --minus-style '\''red'\'' --minus-emph-style '\''red 52'\'' \
      --zero-style '\''normal'\'' \
      --plus-style '\''green'\'' --plus-emph-style '\''green 22'\'' \
      --hunk-header-line-number-style '\''magenta underline'\'' \
      --hunk-header-style '\''bold underline line-number syntax'\'' --hunk-header-decoration-style '\''omit'\'' \
      --file-style '\''omit'\'' --file-decoration-style '\''omit'\'' \
      --commit-style '\''bold yellow'\'' '
  preview_command="git diff $commit_minus $commit_plus "'{-1} | '"$delta_command"

  ${status_command[@]} | $filter_command |
  $(__fzfcmd) -m --ansi --nth 2.. \
    --preview-window wrap:right:70% \
    --preview "$preview_command" |
  awk '{print $2}' | sed 's/.* -> //'

}
alias gss=_git-files-fuzzy
compdef _git _git-files-fuzzy=git-diff

_git-checkout-local-branches-fuzzy() {
  is_in_git_repo || return
  chosen_branch=$(git branch --color=always | grep -v '/HEAD\s' | sort |
  $(__fzfcmd) --ansi --multi --tac --preview-window right:70% \
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
  $(__fzfcmd) --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

_git-history-fuzzy() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  $(__fzfcmd) --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview-window right:70% \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}" |
  tr '\n' ' '
}
alias gdiff="_git-history-fuzzy"

_git-stash-fuzzy() {
  is_in_git_repo || return
  git stash list | $(__fzfcmd) --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

