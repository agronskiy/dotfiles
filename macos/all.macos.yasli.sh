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

# tmux
install_neovim() {
    brew install neovim
}
exists_neovim() {
    [ -x "$(command -v nvim)" ]
}
install_wrapper "neovim" install_neovim exists_neovim
