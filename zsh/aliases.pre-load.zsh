# Alias for git log graph
# alias glog='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias glog='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"'
alias gloga='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)" --all'
alias gloga2='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n""          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'

# Colorized output
alias cat="bat --plain"

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


# ls business, anything related.
# We keep original ls untouched bia exa

alias ls="ls -aCGpF --color=auto"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"  # ls colors

# Exa is a tool which is allegedly cooler than ls
alias la="exa -alF --color=always"
function __ll() {
    la "$@" | less -FX
}
alias ll="__ll"

function __tree() {
    exa -alTF -L 2 --color=always "$@" | less -FX
}
alias tree="__tree"

export EXA_COLORS="xa=37:su=37:sf=37:ur=37:uw=37:ux=37:ue=37:gr=37:gw=37:gx=37:tr=37:tw=37:tx=37:uu=33:un=33:da=36"

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

