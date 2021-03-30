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
alias glog='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)" --all'
alias glog2='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n""          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'

# Colorized output
alias cat="bat"

# For ripgrep default options
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
