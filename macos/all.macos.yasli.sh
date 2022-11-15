#!/usr/bin/env bash

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

# tig
install_tig() {
    brew install tig
}
install_wrapper "tig" install_tig

# exa
install_exa() {
    brew install exa
}
install_wrapper "exa" install_exa

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
    cd $HOME/.local/bin/neovim-install \
    && curl -LO https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-macos.tar.gz \
    && xattr -c ./nvim-macos.tar.gz \
    && tar xzvf ./nvim-macos.tar.gz \
    && ln -sf "$(realpath ./nvim-macos/bin/nvim)" "$HOME/.local/bin/nvim"
}
exists_neovim() {
  [ -x "$(command -v nvim)" ] && nvim --version | grep -q "0.8.0"
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
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
    cd "$HOME/.local/bin/lazygit-install" \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Darwin_x86_64.tar.gz" \
    && sudo tar xf lazygit.tar.gz -C "$HOME/.local/bin" lazygit \
    && rm -rf lazygit.tar.gz
}
exists_lazygit() {
  [ -x "$(command -v lazygit)" ]
}
install_wrapper "lazygit" install_lazygit exists_lazygit

