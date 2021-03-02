#!/usr/bin/env bash
#
# Install Homebrew

# Check for Homebrew.
if ! [ -x "$(command -v brew)" ]
then
    echo "  Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

