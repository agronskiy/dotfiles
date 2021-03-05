#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

if ! [ "$(uname -s)" == "Darwin" ]; then
    log_success "Skipped macos-specific stuff"
fi

# Keeping you awake

brew info keepingyouawake &>/dev/null
if [ $? -eq 0 ]
then
    log_success "Skipped keepingyouawake"
else
    log_info "Installing keepingyouawake"
    brew install --cask keepingyouawake
    if [ $? -eq 0 ]
    then
        log_success "Successfully installed keepingyouawake"
    else
        log_fail "Failed to install keepingyouawake"
    fi
fi
