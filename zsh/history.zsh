
HISTSIZE=1000000            #  How many lines of history to keep in memory
HISTFILE=~/.zsh_history     # Where to save history to disk
SAVEHIST=1000000               # Number of history entries to save to disk
HISTDUP=erase               # Erase duplicates in the history file
setopt    sharehistory      # Share history across terminals
setopt    incappendhistory  # Immediately append to the history file, not just when a term is killed
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Wanting up-down arrows to be still local, credit of
# https://superuser.com/questions/446594/separate-up-arrow-lookback-for-local-and-global-zsh-history/691603#691603
bindkey "${key[Up]}" up-line-or-local-history
bindkey "${key[Down]}" down-line-or-local-history
bindkey "^P" up-line-or-local-history
bindkey "^N" down-line-or-local-history

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
__fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected=( $(fc -rli 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index
    --preview-window down:6:wrap --preview='printf '\''%s'\'' {}'
    --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
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

# NOTE(agronskiy): unused since moving to zsh
log_persistent_history_unused()
{
    local COMMAND_PART=$1
    local COMMAND_PART_NONEWLINE=("${COMMAND_PART//'\'$'\n'/}")
    COMMAND_PART_NONEWLINE=("${COMMAND_PART_NONEWLINE//$'\n'/}")
    if [ "$COMMAND_PART_NONEWLINE" != "$PERSISTENT_HISTORY_LAST" ] \
        && ! [[ "$COMMAND_PART_NONEWLINE " =~ ^(no)?hh[[:space:]]+ ]] \
        && ! [[ $COMMAND_PART_NONEWLINE =~ ^[[:space:]] ]];
    then
        echo "$(date "+%Y-%m-%d %H:%M:%S")" " | " "$COMMAND_PART_NONEWLINE" >> ~/.persistent_history
        export PERSISTENT_HISTORY_LAST="$COMMAND_PART_NONEWLINE"
    fi
}
