# Makes colors in CLI ls output
case `uname` in
    Darwin)
        alias ls="ls -aCGpF"  # ls output with "/" for folders and @ for symlinks
        alias ll="ls -alGpF"
    ;;
    Linux)
        alias ls="ls -aCGpF --color=auto"  # ls output with "/" for folders and @ for symlinks
        alias ll="ls -alGpF --color=auto"
    ;;
esac

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"  # ls colors

# Alias for git log graph
# alias glog='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias glog='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"'
alias gloga='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)" --all'
alias gloga2='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n""          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'

# Colorized output
alias cat="bat"

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
