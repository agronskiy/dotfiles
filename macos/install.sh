#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

if ! [ "$(uname -s)" == "Darwin" ]; then
    log_success "Skipped macos-specific stuff"
    exit 0
fi

# Keeping you awake
install_keepingyouawake() {
    brew list --cask keepingyouawake &>/dev/null
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
}
install_keepingyouawake

# Keeping you awake
install_fd() {
    brew list fd &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped fd"
    else
        log_info "Installing fd"
        brew install fd
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed fd"
        else
            log_fail "Failed to install fd"
        fi
    fi
}
install_fd
