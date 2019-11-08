EDITOR='subl -wn' 
alias slt='subl -w'


# Various useful colors
# 
# Check https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt 
# for more colors codes
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
 LIGHT_BLUE="\[\033[38;5;81m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\033[0m\]"

# For iPython Notebook issue - need to set the locale, but not all (?)
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8

export LC_CTYPE=en_US.UTF-8

# Makes colors in CLI ls output
export CLICOLOR=1
alias ls="ls -GpF"  # ls output with "/" for folders
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"  # ls colors

# Following commented out (see DDLN-specific below)
# # Line of invitation to type a command
# export PS1="\u: \W\$ "

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Sourcing the autocompletion, see https://docs.brew.sh/Shell-Completion
HOMEBREW_PREFIX=$(brew --prefix)
if type brew &>/dev/null; then
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# FOR GO:
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# For tensorflow/models/research: see 
# https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md
PYTHONPATH=$PYTHONPATH:$HOME/repos
export PYTHONPATH


# Setting prompt command to branch status
source /usr/local/etc/bash_completion.d/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1

PROMPT_DIRTRIM=3

# Determine active Python virtualenv details.
function get_virtualenv() {
    if ! test -z "$VIRTUAL_ENV" ; then
       echo "${YELLOW}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
    fi
    if ! test -z "$CONDA_DEFAULT_ENV" ; then
       echo "${YELLOW}[`basename \"$CONDA_DEFAULT_ENV\"`]${COLOR_NONE} "
    fi
}

function get_err_code() {
    local EXIT="$?"
    CODE=""
    if [ $EXIT != 0 ]; then
        echo "${RED}[✗]${COLOR_NONE} "
    else
        echo "${LIGHT_GREEN}[✓]${COLOR_NONE} "
    fi
}

function middle_part() {
    # echo -e "${BLUE}\u:${WHITE}$(python ~/.short_pwd.py)${COLOR_NONE}"
    echo -e "${BLUE}\u:${WHITE}\w${COLOR_NONE}"
}

function prompt_symbol() {
    echo -e  "\n${LIGHT_GREEN}➙  "
}

function __prompt_command() {
    # Add last line to history (see Luuk's permanenthistory.sh in git
    __git_ps1 "\n$(get_err_code)$(get_virtualenv)$(middle_part)" "$(prompt_symbol)"

}
# export PS1="${WHITE}\u:${COLOR_NONE}\w ${LIGHT_BLUE}\$${COLOR_NONE}"
PROMPT_COMMAND=__prompt_command
trap 'tput sgr0' DEBUG

# Alias for git log graph
# alias glog='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias glog='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)" --all'
alias glog2='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n""          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'
export PATH="/usr/local/opt/ruby/bin:$PATH"


# Anaconda
export PATH=/usr/local/anaconda3/bin:$PATH
source activate py-3.6

# For some small files
export PATH=$HOME/bin:$PATH
