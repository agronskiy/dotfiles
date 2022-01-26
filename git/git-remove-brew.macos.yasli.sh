#!/usr/bin/env bash

# Removes macos git autocompletions from brew

# `install` is kind of reversed here because we actually delete
install_git_brew_delete_patch() {
    rm /usr/local/share/zsh/site-functions/_git
}
exists_git_brew_delete_patch() {
    [ ! -f "/usr/local/share/zsh/site-functions/_git" ]
}
install_wrapper "patch for brew's git" \
    install_git_brew_delete_patch \
    exists_git_brew_delete_patch
