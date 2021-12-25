#!/usr/bin/env bash

# fd
__install_fd() {
    brew install fd
}
install_wrapper "fd" __install_fd

# htop
__install_htop() {
    brew install htop
}
install_wrapper "htop" __install_htop


# bat
__install_bat() {
    brew install bat
}
install_wrapper "bat" __install_bat

# ripgrep
__install_ripgrep() {
    brew install ripgrep
}
__check_ripgrep() {
    brew list ripgrep &>/dev/null
}
install_wrapper "ripgrep" __install_ripgrep __check_ripgrep

# coreutils
__install_coreutils() {
    brew install coreutils
}
__check_coreutils() {
    brew list coreutils &>/dev/null
}
install_wrapper "coreutils" __install_coreutils __check_coreutils

# tree
__install_tree() {
    brew install tree
}
install_wrapper "tree" __install_tree

# tig
__install_tig() {
    brew install tig
}
install_wrapper "tig" __install_tig

# exa
__install_exa() {
    brew install exa
}
install_wrapper "exa" __install_exa

# delta
__install_delta() {
    brew install git-delta
}
install_wrapper "delta" __install_delta

# jq
__install_jq() {
    brew install jq
}
install_wrapper "jq" __install_jq
