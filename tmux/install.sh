#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

log_info "Installing tmux-tpm"

if [ ! -d $HOME/.tmux/plugins/tpm/.git ]
then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    log_success "Cloned tmux-tpm"
else
    (
        cd $HOME/.tmux/plugins/tpm
        git pull
        log_success "Pulled tmux-tpm"
    )
fi
