#!/usr/bin/env bash
#
# Install Homebrew

# TODO(agronskiy) logging

if [ ! -d $HOME/.tmux/plugins/tpm/.git ]
then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
    (
        cd $HOME/.tmux/plugins/tpm
        git pull
    )
fi
