#!/usr/bin/env bash
#
# NOTE(agronskiy) Nore that tmux-resurrect is custom version with ad-hoc patch.

install_tmux_tpm() {
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm \
        && TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins /$HOME/.tmux/plugins/tpm/bin/install_plugins
}
exists_tmux_tpm () {
    [ -d $HOME/.tmux/plugins/tpm/.git ]
}
update_tmux_tpm () {
    ( cd $HOME/.tmux/plugins/tpm && git pull &> /dev/null )
}
install_wrapper "tmux tpm" \
    install_tmux_tpm \
    exists_tmux_tpm \
    update_tmux_tpm

