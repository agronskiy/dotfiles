#!/usr/bin/env bash
#
# NOTE(agronskiy) Nore that tmux-resurrect is custom version with ad-hoc patch.

log_info "Installing tmux-tpm"

if [ ! -d $HOME/.tmux/plugins/tpm/.git ]
then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm  2>&1 | log_cmd
    TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins /$HOME/.tmux/plugins/tpm/bin/install_plugins  2>&1 | log_cmd
    log_success "Cloned tmux-tpm"
else
    (
        cd $HOME/.tmux/plugins/tpm
        git pull &> /dev/null 2>&1 | log_cmd
        if [ $? -eq 0 ]; then
            log_success "Pulled tmux-tpm"
        else
            log_fail "Error pulling tmux-tpm"
        fi
    )
fi
