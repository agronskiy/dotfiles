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
        git pull &> /dev/null
        if [ $? -eq 0 ]; then
            log_success "Pulled tmux-tpm"
        else
            log_fail "Error pulling tmux-tpm"
        fi
    )
fi

# This needs to be run AFTER the tpm loads scripts for the first time.
# See the `drop-in-replace-resurrect`
if [ -d $HOME/.tmux/plugins/tmux-resurrect/scripts ]
then
    cp $DOTFILES/tmux/drop-in-replace-resurrect.sh $HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh
    log_success "Replaced $HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh"
fi
