
export HISTSIZE=2000000            #  How many lines of history to keep in memo
export HISTFILE=~/.zsh_history     # Where to save history to disk
export SAVEHIST=2000000               # Number of history entries to save to disk
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

# Wanting up-down arrows to be still local, credit of
# https://superuser.com/questions/446594/separate-up-arrow-lookback-for-local-and-global-zsh-history/691603#691603
bindkey "${key[Up]}" up-line-or-local-history
bindkey "${key[Down]}" down-line-or-local-history
bindkey "^P" up-command-local-history
bindkey "^N" down-command-local-history

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history

up-command-local-history() {
    zle set-local-history 1
    zle up-history
    zle set-local-history 0
}
zle -N up-command-local-history
down-command-local-history() {
    zle set-local-history 1
    zle down-history
    zle set-local-history 0
}
zle -N down-command-local-history
# End of dividing history

# Finding history
# Version old - using grep and allowing to see long commands
function hh()
{
    if [[ $# -eq 0 ]]; then
        fc -lin 1 | tail -n 50
    elif [[ $# -eq 1 ]]; then
        fc -lin 1 | grep -i --color=always -- "$1" | tail -n 50
    elif [[ $# -eq 2 ]]; then
        fc -lin 1 | grep -i --color=always -- "$1" | grep -i --color=always -- "$2" | tail -n 50
    elif [[ $# -eq 3 ]]; then
        fc -lin 1 | grep -i --color=always -- "$1" | grep -i --color=always -- "$2" | grep -i --color=always -- "$3" | tail -n 50
    fi
}

# New version - widget bound to Ctrl-R
# NOTE(agronskiy): this is taken and enhanced from
# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
__fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  # Sed's below strip date information such as `123 2021-11-01 09:48` and then replace `\n` with
  # newlines.
  sed_preview='s#^[[:space:]]\{0,\}\([^[:space:]]\{1,\}[[:space:]]\{1,\}\)\{3\}#  #;s#\\n#\
    #g'

  # Bat below highlights the command with bash syntax.
  selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --scheme=history
    --preview-window down:15:wrap --preview='printf '\''%s'\'' {} |
    sed '\''$sed_preview'\'' |
    bat --color=always --plain -l '\''Bourne Again Shell (bash)'\'' '
    ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N   __fzf-history-widget
bindkey '^R' __fzf-history-widget
bindkey 'jk' __fzf-history-widget

