#!/usr/bin/env bash

if [ "$(uname -s)" == "Linux" ]
then
    (
        echo "Installing miniconda (Linux)"
        cd /tmp

        if [ -f "Miniconda3-latest-Linux-x86_64.sh" ]; then
            rm Miniconda3-latest-Linux-x86_64.sh
        fi
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
        chmod +x Miniconda3-latest-Linux-x86_64.sh
        ./Miniconda3-latest-Linux-x86_64.sh
        rm Miniconda3-latest-Linux-x86_64.sh
    )
elif [ "$(uname -s)" == "Darwin" ]
then
    brew install miniconda
fi
