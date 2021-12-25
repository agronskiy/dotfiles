# This is result of digging into https://stackoverflow.com/questions/70267661/make-fzf-tab-completion-only-return-files-for-specific-command-caveat-ins

__custom_fzf_generic_path_completion() {
  local base lbuf cmd compgen fzf_opts suffix tail dir leftover matches
  base=$1
  lbuf=$2
  cmd=$(__fzf_extract_command "$lbuf")
  compgen=$3
  fzf_opts=$4
  suffix=$5
  tail=$6

  setopt localoptions nonomatch
  eval "base=$base"
  [[ $base = *"/"* ]] && dir="$base"
  while [ 1 ]; do
    if [[ -z "$dir" || -d ${dir} ]]; then
      leftover=${base/#"$dir"}
      leftover=${leftover/#\/}
      [ -z "$dir" ] && dir='.'
      [ "$dir" != "/" ] && dir="${dir/%\//}"
      matches=$(eval "$compgen $(printf %q "$dir")" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_COMPLETION_OPTS" __fzf_comprun "$cmd" ${(Q)${(Z+n+)fzf_opts}} -q "$leftover" | while read item; do
        echo -n "${(q)item}$suffix "
      done)
      matches=${matches% }
      if [ -n "$matches" ]; then
        LBUFFER="$lbuf$matches$tail"
      fi
      break
    fi
    dir=$(dirname "$dir")
    dir=${dir%/}/
  done
}

__custom_fzf_file_compgen_path() {
  fd --type f --hidden --follow --no-ignore --exclude ".git" . "$1"
}

__custom_fzf_file_path_completion() {
  __custom_fzf_generic_path_completion "$1" "$2" __custom_fzf_file_compgen_path \
    "-m" "" " "
}
