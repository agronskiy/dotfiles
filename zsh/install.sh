#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

if ! [ -x "$(command -v fzf)" ]
then
    log_info "Installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" && "$HOME/.fzf/install"
    return_val=$?

    if [ $return_val -ne 0 ]; then
        log_fail "Failed to install fzf"
    else
        log_success "Installed fzf"
    fi
else
    log_info "Skipped installing fzf"
fi
