#!/usr/bin/env bash
#
# NOTE(agronskiy) Nore that tmux-resurrect is custom version with ad-hoc patch.


source $DOTFILES/zsh/logging.explicit-load.zsh

log_info "Installing tmux-tpm"

if [ ! -d $HOME/.tmux/plugins/tpm/.git ]
then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins /$HOME/.tmux/plugins/tpm/bin/install_plugins
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
