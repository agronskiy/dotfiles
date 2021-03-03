# Various useful colors
#
# Check https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt
# for more colors codes
        RED="%{\033[0;31m%}"
     YELLOW="%{\033[0;33m%}"
      GREEN="%{\033[0;32m%}"
       BLUE="%{\033[1;34m%}"
  LIGHT_RED="%{\033[1;31m%}"
LIGHT_GREEN="%{\033[1;32m%}"
 LIGHT_BLUE="%{\033[38;5;81m%}"
      WHITE="%{\033[1;37m%}"
 LIGHT_GRAY="%{\033[0;37m%}"
 COLOR_NONE="%{\033[0m%}"

    NEWLINE=$'\n'


# Setting prompt command to branch status
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1

source $DOTFILES/zsh/git-prompt.explicit-load.zsh

# Determine active Python virtualenv details.
function get_virtualenv() {
    if ! test -z "$VIRTUAL_ENV" ; then
        echo "${YELLOW}(`basename \"$VIRTUAL_ENV\"`)${COLOR_NONE} "
    fi
    if ! test -z "$CONDA_DEFAULT_ENV" ; then
        echo "${YELLOW}(`basename \"$CONDA_DEFAULT_ENV\"`)${COLOR_NONE} "
    fi
}

function get_err_code() {
    local EXIT_CODE=$?
    echo -e ${EXIT_CODE}
}

# Unused
function display_err_code() {
    local EXIT_CODE=$1
    if [[ $EXIT_CODE -ne 0 ]]; then
        echo "${LIGHT_RED}[✘]${COLOR_NONE} "
    else
        echo "${LIGHT_GREEN}[✔]${COLOR_NONE} "
    fi
}

function middle_part() {
    # For the trick with path shortening, see https://unix.stackexchange.com/questions/273529/shorten-path-in-zsh-prompt
    # for options.
    path_truncated='%(5~|%-2~/../%2~|%~)'
    echo -e "${BLUE}%n${COLOR_NONE}@${LIGHT_BLUE}%M${COLOR_NONE}: ${WHITE}${path_truncated}${COLOR_NONE}"
}

function prompt_symbol() {
    local EXIT_CODE=$1

    if [[ $EXIT_CODE -ne 0 ]]; then
        local color="${LIGHT_RED}%B"
    else
        local color="${LIGHT_GREEN}%B"
    fi
    echo -e  "\n${color}》${COLOR_NONE}"
}

function precmd() {
    local EXIT_CODE=$(get_err_code)
    # Add $(display_err_code ${EXIT_CODE}) if needed more visual
    __git_ps1   "${NEWLINE}$(get_virtualenv)$(middle_part)"\
                "$(prompt_symbol ${EXIT_CODE})"
}

function preexec () {
    echo -ne "\e[0m"
}

# Coloring partial match https://stackoverflow.com/questions/8300687/zsh-color-partial-tab-completions
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=00}:${(s.:.)LS_COLORS}")';

# Default highlight color of the input
export zle_highlight=( default:fg=7 )
