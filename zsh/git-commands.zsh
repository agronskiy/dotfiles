# Based on https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236s

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

_git-files-fuzzy() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-tmux -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}
alias gss=_git-files-fuzzy

_git-checkout-local-branches-fuzzy() {
  is_in_git_repo || return
  git branch --color=always | grep -v '/HEAD\s' | sort |
  fzf-tmux --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --graph --color=always --abbrev-commit --decorate \
--format=format:\
"%C(bold blue)%h%C(reset) - \
%C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset) %C(dim white)- %an%C(reset)%n\
          %C(white)%s%C(reset) " $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##' |
  git checkout
}
alias gcol="_git-checkout-local-branches-fuzzy"


_git-tag-fuzzy() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-tmux --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

_git-history-fuzzy() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-tmux --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}
alias gdiff="_git-history-fuzzy"

_git-stash-fuzzy() {
  is_in_git_repo || return
  git stash list | fzf-tmux --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}
