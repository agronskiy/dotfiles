# Alias for git log graph
# alias glog='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias glogg='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"'

# Colorized output
alias cat="bat --plain"

# Editor nvim = vim
alias vim="nvim"

# For ripgrep default options
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# Keeping socket for SSH agent forwarding correct, credit of https://werat.dev/blog/happy-ssh-agent-forwarding/
# Outside of TMUX, it links special file to the actual SSH socket. Inside of tmux session, it rebinds
# SSH_AUTH_SOCK to it. This was, via symlink, inside TMUX th socket is always the actual one.
if [ -z ${TMUX+x} ]; then
    # Not in a TMUX session
    if [ ! -S ~/.ssh_auth_sock ] && [ -S "$SSH_AUTH_SOCK" ]; then
        ln -sf $SSH_AUTH_SOCK ${HOME}/.ssh_auth_sock
    fi
else
    # In TMUX
    export SSH_AUTH_SOCK=${HOME}/.ssh_auth_sock
fi

# FZF with --ansi
alias gref="fzf --filter"

# ls business, anything related.
# We keep original ls untouched bia exa

alias ls="ls -aCGpF --color=auto"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"  # ls colors

# Exa is a tool which is allegedly cooler than ls
function __ll() {
    # Check if that's for terminal. If not, don't add `color=always` to prevent ansi escapes in
    # piping.
    if [ -t 1 ]
    then
        exa -lF --color=always "$@" | less
    else
        exa -lF "$@"
    fi
}
alias ll="__ll"
alias la="ll -a"
alias fla="la --color=always | fzf -m --ansi"
alias fll="ll --color=always | fzf -m --ansi"

alias tree="tree -C -F -L 2"
function __tree() {
    # Check if that's for terminal. If not, don't add `color=always` to prevent ansi escapes in
    # piping.
    if [ -t 1 ]
    then
        exa -lTF -L 2 --color=always "$@" | less
    else
        exa -lTF -L 2 "$@"
    fi
}
alias trel="__tree"
alias trela="trel -a"
alias ftrela="ftrel -a"
alias ftrel="trel --color=always | fzf -m --ansi"

export EXA_COLORS="xa=37:su=37:sf=37:ur=37:uw=37:ux=37:ue=37:gr=37:gw=37:gx=37:tr=37:tw=37:tx=37:uu=33:un=33:da=36"

# LESS pager
export LESS="-F -R -X -i"

# multiline ripgrep
alias rgm="rg --multiline"

# git-delta defaul options
export DELTA_DEFAULT_OPTS=\
"--minus-style red --minus-emph-style 'red 52' "\
"--zero-style normal "\
"--plus-style green --plus-emph-style 'green 22' "\
"--hunk-header-line-number-style magenta "\
"--hunk-header-style 'bold file line-number syntax' --hunk-header-decoration-style 'ul ol' "\
"--file-style omit --file-decoration-style omit "\
"--commit-style 'bold yellow' "

alias delta="delta $DELTA_DEFAULT_OPTS "

export GPG_TTY=$TTY

# Syncs the zsh history, using scripts histpull/histpush from `./bin`
alias histsync="histpull && builtin fc -R -I && builtin fc -W && histpush"

# If one does not want to use `exa`
# # Makes colors in CLI ls output
# case `uname` in
#     Darwin)
#         alias ls="ls -aCGpF --color=auto"  # ls output with "/" for folders and @ for symlinks
#         alias ll="ls -alGpF --color=auto"
#     ;;
#     Linux)
#         alias ls="ls -aCGpF --color=auto"  # ls output with "/" for folders and @ for symlinks
#         alias ll="ls -alGpF --color=auto"
#     ;;
# esac

# export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"  # ls colors

# # Tree colorized output
# alias __tree="tree -C -F -L 2"
# # For the "less" version of "tree", we need a function - it passes arguments inside
# function tree() {
#     __tree "$@" | less
# }

