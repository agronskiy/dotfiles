#!/usr/bin/env bash

# For mac, this is not a standard bin location, so to make the `exists_...` (where we install
# some binaries) commands below work we need to ensure it is in `PATH`.
export PATH="$HOME/.local/bin:$PATH"

# fd
install_fd() {
    brew install fd
}
install_wrapper "fd" install_fd

# htop
install_htop() {
    brew install htop
}
install_wrapper "htop" install_htop

# bat
install_bat() {
    brew install bat
}
install_wrapper "bat" install_bat

# ripgrep
install_ripgrep() {
    brew install ripgrep
}
exists_ripgrep() {
    brew list ripgrep &>/dev/null
}
install_wrapper "ripgrep" install_ripgrep exists_ripgrep

# coreutils
install_coreutils() {
    brew install coreutils
}
exists_coreutils() {
    brew list coreutils &>/dev/null
}
install_wrapper "coreutils" install_coreutils exists_coreutils

# tree
install_tree() {
    brew install tree
}
install_wrapper "tree" install_tree

# eza
install_eza() {
    brew install eza
}
install_wrapper "eza" install_eza

# delta
install_delta() {
    brew install git-delta
}
install_wrapper "delta" install_delta

# jq
install_jq() {
    brew install jq
}
install_wrapper "jq" install_jq

# tmux
install_tmux() {
    brew install tmux
}
install_wrapper "tmux" install_tmux


# neovim
install_neovim() {
    [ -d "$HOME/.local/bin/neovim-install" ] && rm -rf "$HOME/.local/bin/neovim-install"
    mkdir -p "$HOME/.local/bin/neovim-install"
    cd "$HOME/.local/bin/neovim-install" \
    && curl -LO https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-macos-x86_64.tar.gz \
    && xattr -c ./nvim-macos-x86_64.tar.gz \
    && tar xzvf ./nvim-macos-x86_64.tar.gz \
    && ln -sf -r "$(realpath ./nvim-macos-x86_64/bin/nvim)" "$HOME/.local/bin/nvim"
}
exists_neovim() {
  [ -x "$(command -v nvim)" ] && nvim --version | grep -q "0.10.2"
}
install_wrapper "neovim" install_neovim exists_neovim

# nodejs
install_nodejs() {
    brew install nodejs
}
exists_nodejs() {
    [ -x "$(command -v node)" ]
}
install_wrapper "nodejs" install_nodejs exists_nodejs

# install shellcheck
install_shellcheck() {
  brew install shellcheck
}
exists_shellcheck() {
  [ -x "$(command -v shellcheck)" ]
}
install_wrapper "shellcheck" install_shellcheck exists_shellcheck

# lazygit
install_lazygit() {
    [ -d "$HOME/.local/bin/lazygit-install" ] && rm -rf "$HOME/.local/bin/lazygit-install"
    mkdir -p "$HOME/.local/bin/lazygit-install"
    # LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
    LAZYGIT_VERSION=0.38.2
    cd "$HOME/.local/bin/lazygit-install" \
    && log_info "getting https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Darwin_x86_64.tar.gz" \
    && curl -L "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Darwin_x86_64.tar.gz" -o lazygit.tar.gz \
    && tar -xf lazygit.tar.gz -C "$HOME/.local/bin" lazygit \
    && rm -rf lazygit.tar.gz
}
exists_lazygit() {
  [ -x "$(command -v lazygit)" ]
}
install_wrapper "lazygit" install_lazygit exists_lazygit

# install k9s
install_k9s() {
  curl -sS https://webinstall.dev/k9s | bash
}
exists_k9s() {
    [ -x "$(command -v k9s)" ]
}
install_wrapper "k9s" install_k9s exists_k9s

# install pynvim
install_pynvim() {
    sys_python=$(which -a python3 | head -n2 | tail -n1)
    $SUDO_CMD $sys_python -m pip install pynvim
}
exists_pynvim() {
    sys_python=$(which -a python3 | head -n2 | tail -n1)
    $sys_python -c 'import pynvim'
}
install_wrapper "pynvim" install_pynvim exists_pynvim


