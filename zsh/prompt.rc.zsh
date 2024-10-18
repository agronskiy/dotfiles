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
 LIGHT_BLUE="%{\033[0;38;5;81m%}"
      WHITE="%{\033[1;37m%}"
 LIGHT_GRAY="%{\033[0;37m%}"
      RESET="%{\033[0m%}"
       BOLD="%{\033[1m%}"

    NEWLINE=$'\n'


# Setting prompt command to branch status
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1

source $DOTFILES/zsh/git-prompt.inc.zsh

# Determine active Python virtualenv details.
function get_virtualenv() {
    if ! test -z "$VIRTUAL_ENV" ; then
        echo "${YELLOW}(`basename \"$VIRTUAL_ENV\"`)${RESET} "
    fi
    if ! test -z "$CONDA_DEFAULT_ENV" ; then
        echo "${YELLOW}(`basename \"$CONDA_DEFAULT_ENV\"`)${RESET} "
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
        echo "${LIGHT_RED}[✘]${RESET} "
    else
        echo "${LIGHT_GREEN}[✔]${RESET} "
    fi
}

function middle_part() {
    # For the trick with path shortening, see https://unix.stackexchange.com/questions/273529/shorten-path-in-zsh-prompt
    # for options.
    path_truncated='%(5~|%-2~/../%2~|%~)'

    # NOTE(agronskiy): use below `host_color` if need to highlight different hosts with different colors.
    local salt="salt"
    local color_number=$( (echo "${salt}"; hostname) | od | tr ' ' '\n' | awk '{total = total + $1}END{print 31 + (total % 6)}')
    local color_brightness=$( (echo "${salt}"; hostname) | od | tr ' ' '\n' | awk '{total = total + $1}END{print (total % 2)}')
    local host_color="%{\033[${color_brightness};${color_number}m%}"

    local is_root=""
    if [ "$EUID" -eq 0 ]; then
        is_root="${LIGHT_RED}[root]${RESET}@"
    fi

    # NOTE(agronskiy): set THIS_HOST_PROMPT_COLOR in .localrc of your host to override the default LIGHT_BLUE
    if [ ! -z ${TMUX+x} ]; then
        local host_name=""
    else
        local host_name="${THIS_HOST_PROMPT_COLOR:=${LIGHT_BLUE}}[${THIS_HOST_PROMPT_NAME:=%M}] "
    fi
    echo -e "${is_root}${host_name}${RESET}${WHITE}${path_truncated}${RESET}"
}

function prompt_symbol() {
    local EXIT_CODE=$1

    if [[ $EXIT_CODE -ne 0 ]]; then
        local color="${LIGHT_RED}%B"
    else
        local color="${LIGHT_GREEN}%B"
    fi
    echo -e  "\n${color}❱ ${RESET}"
}

function precmd() {
    local EXIT_CODE=$(get_err_code)
    # Add $(display_err_code ${EXIT_CODE}) if needed more visual
    __git_ps1   "${NEWLINE}\$(kube_ps1)$(get_virtualenv)$(middle_part)"\
                "$(prompt_symbol ${EXIT_CODE})"
}

function preexec () {
    echo -ne "\e[0m"
}

# Avoid random percent sign.
# See https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
export PROMPT_EOL_MARK=''


# Some kube_ps1 configuration, see https://github.com/jonmosco/kube-ps1?tab=readme-ov-file#customization
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_SUFFIX=") "
