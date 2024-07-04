# Based on https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236s

__RESTORE=$(echo -en '\033[0m')
__RED=$(echo -en '\033[00;31m')
__GREEN=$(echo -en '\033[00;32m')

_is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

_relative_path_helper() {
  # Make path to the file relative to the current place, otherwise the viewer breaks - because the
  # `git diff` returns path relative to root.
  local split_array

  while IFS= read -r line
  do
      # Lines are in the format `M some/path/to/file`, OR `Rxxx path/before/rename
      # path/after/rename`. Replace `-A` by `-a` for bash.
      read -r -A split_array <<< "$line"

      case ${split_array[1]} in
        [DM])
          split_array[1]="${__RED}${split_array[1]}${__RESTORE}"
          ;;
        A)
          split_array[1]="${__GREEN}${split_array[1]}${__RESTORE}"
          ;;
      esac
      path_to_root="$(realpath --quiet --relative-to=. $(git rev-parse --show-toplevel)/)"
      split_array[-1]=$path_to_root/${split_array[-1]}
      [ ${#split_array[@]} -ge 3 ] && split_array[-2]=$path_to_root/${split_array[-2]}
      echo ${split_array[@]}
  done
}

_git-files-fuzzy() {
  _is_in_git_repo || return
  if [ -z "$1" ]; then
    commit_minus=""
    commit_plus=""
    status_command=$(git -c color.status=always status --short)
    filter_command=cat
  else
    commit_minus="$1"
    if [ -z "$2" ]; then
      commit_plus="HEAD"
    else
      commit_plus="$2"
      # As an addition let's sort two commits so that minus goes before plus
      git rev-list $commit_minus | grep $(git rev-parse $commit_plus) > /dev/null 2>&1
      if [ ${pipestatus[-1]} -eq 0 ]; then
        temp=$commit_minus
        commit_minus=$commit_plus
        commit_plus=$temp
      fi
    fi
    status_command=$(git diff --name-status $commit_minus $commit_plus | _relative_path_helper)
    filter_command=(tr '\t' ' ')
  fi
  preview_command="git diff $commit_minus $commit_plus "'{-1} | delta -n '"${DELTA_DEFAULT_OPTS:-}"


  printf "%s\n" "${status_command[@]}" |
  $filter_command |
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 95%" \
  fzf-tmux $FZF_TMUX_OPTS -p 95%,95% -- -m --ansi --nth 2.. \
    --preview-window wrap:up:70% \
    --preview "$preview_command" |
  awk '{print $2}' | sed 's/.* -> //'

}
alias gss=_git-files-fuzzy
compdef _git _git-files-fuzzy=git-diff

_git-checkout-local-branches() {
  _is_in_git_repo || return

  if [ ! -z $1 ]; then
    chosen_branch=$1
  else
    return
  fi

  if [ ! -z "$chosen_branch" ] ; then
    git checkout $chosen_branch
  fi
}
alias gcol=_git-checkout-local-branches
compdef _gcol-completion _git-checkout-local-branches

_gcol-completion () {
  local -a copts=( -o nosort )

  _arguments -C -s -O copts \
    '*:: :($(git for-each-ref --sort=-committerdate --format='"'%(refname:short)'"' refs/heads/))' && ret=0

  return ret
}

zstyle ':fzf-tab:complete:(_git-checkout-local-branches|git-checkout):*' fzf-preview \
  'git log --graph --color=always --abbrev-commit --decorate \
--format=format:\
"%C(bold blue)%h%C(reset) - \
%C(bold green)(%as)%C(reset)%C(auto)%d%C(reset) %C(dim white)- %an%C(reset)%n\
          %C(white)%s%C(reset) " \
$word'


_git-tag-fuzzy() {
  _is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-tmux $FZF_TMUX_OPTS --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

_git-history-fuzzy() {
  _is_in_git_repo || return

  glogg --color=always |
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 90%" \
  fzf-tmux $FZF_TMUX_OPTS -p 95%,90% -- --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort, CTRL-/ for diff preview ' \
    --preview-window hidden:wrap:right:80% \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | (xargs git show | delta -n '"${DELTA_DEFAULT_OPTS:-}"' ) ' |
  grep -o "[a-f0-9]\{7,\}" |
  tr '\n' ' '
}
alias glog="_git-history-fuzzy"

_git-stash-fuzzy() {
  _is_in_git_repo || return
  git stash list | fzf-tmux $FZF_TMUX_OPTS --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

# lists all branhes without remote, credit of https://stackoverflow.com/questions/15661853/list-all-local-branches-without-a-remote
alias git-list-no-remote="git branch --format \"%(refname:short) %(upstream)\" | awk '{if (!\$2) print \$1;}'"
