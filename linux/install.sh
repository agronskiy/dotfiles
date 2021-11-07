#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

if ! [ "$(uname -s)" == "Linux" ]; then
    log_success "Skipped linux-specific stuff"
    exit 0
fi

# Add here linux-specific installations

# # TEMPLATE
# install_TEMPLATE() {
#     brew list --cask TEMPLATE &>/dev/null
#     if [ $? -eq 0 ]
#     then
#         log_success "Skipped TEMPLATE"
#     else
#         log_info "Installing TEMPLATE"
#         brew install --cask TEMPLATE
#         if [ $? -eq 0 ]
#         then
#             log_success "Successfully installed TEMPLATE"
#         else
#             log_fail "Failed to install TEMPLATE"
#         fi
#     fi
# }
# install_TEMPLATE

install_fd() {
    which fdfind &>/dev/null
    if [ $? -eq 0 ]
    then
        # Have fd in the .local/bin directory
        mkdir -p "$HOME/.local/bin/"
        ln -s --force $(which fdfind) "$HOME/.local/bin/fd"
        log_success "Skipped fd, relinked"
    else
        log_info "Installing fd"
        sudo apt-get install fd-find
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed fd"
        else
            log_fail "Failed to install fd"
        fi
    fi
}
install_fd

# htop
install_htop() {
    which htop &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped htop"
    else
        log_info "Installing htop"
        sudo apt-get install htop
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed htop"
        else
            log_fail "Failed to install htop"
        fi
    fi
}
install_htop

# bat
install_bat() {
    which batcat &>/dev/null
    if [ $? -eq 0 ]
    then
        # Due to packaage clash they  have renamed bat to batcat, linking back
        ln -s --force $(which batcat) "$HOME/.local/bin/bat"
        log_success "Skipped bat, relinked"
    else
        log_info "Installing bat"
        sudo apt-get -y install bat
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed bat"
        else
            log_fail "Failed to install bat"
        fi
    fi
}
install_bat


# ripgrep
install_ripgrep() {
    which rg &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped ripgrep"
    else
        log_info "Installing ripgrep"
        curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
        sudo dpkg -i ripgrep_12.1.1_amd64.deb
        rm ripgrep_12.1.1_amd64.deb
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed ripgrep"
        else
            log_fail "Failed to install ripgrep"
        fi
    fi
}
install_ripgrep

# tree
install_tree() {
    which tree &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped tree"
    else
        log_info "Installing tree"
        sudo apt-get install tree
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed tree"
        else
            log_fail "Failed to install tree"
        fi
    fi
}
install_tree

# tig
install_tig() {
    which tig &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped tig"
    else
        log_info "Installing tig"
        sudo apt-get install tig
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed tig"
        else
            log_fail "Failed to install tig"
        fi
    fi
}
install_tig

# exa
install_exa() {
    which exa &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped exa"
    else
        log_info "Installing exa"

        mkdir /tmp/exa-install
        cd /tmp/exa-install

        if ! command -v rustc &> /dev/null
        then
            curl https://sh.rustup.rs -sSf | sh -s -- -y
        fi
        sudo apt-get install -y build-essential
        $HOME/.cargo/bin/cargo install exa
        cp $HOME/.cargo/bin/exa $HOME/.local/bin

        cd ~
        rm -rf /tmp/exa-install

        if [ $? -eq 0 ]
        then
            log_success "Successfully installed exa"
        else
            log_fail "Failed to install exa"
        fi
    fi
}
install_exa
