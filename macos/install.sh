#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

if [ "$(uname -s)" != "Darwin" ]; then
    log_success "Skipped macos-specific stuff"
    exit 0
fi

# Keeping you awake
install_keepingyouawake() {
    brew list --cask keepingyouawake &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped keepingyouawake"
    else
        log_info "Installing keepingyouawake"
        brew install --cask keepingyouawake
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed keepingyouawake"
        else
            log_fail "Failed to install keepingyouawake"
        fi
    fi
}
install_keepingyouawake

# Keeping you awake
install_fd() {
    brew list fd &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped fd"
    else
        log_info "Installing fd"
        brew install fd
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
    brew list htop &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped htop"
    else
        log_info "Installing htop"
        brew install htop
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
    brew list bat &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped bat" 
    else
        log_info "Installing bat" 
        brew install bat 
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
    brew list ripgrep &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped ripgrep" 
    else
        log_info "Installing ripgrep" 
        brew install ripgrep 
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed ripgrep" 
        else
            log_fail "Failed to install ripgrep" 
        fi
    fi
}
install_ripgrep

# coreutils  
install_coreutils() {
    brew list coreutils &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped coreutils" 
    else
        log_info "Installing coreutils" 
        brew install coreutils 
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed coreutils" 
        else
            log_fail "Failed to install coreutils" 
        fi
    fi
}
install_coreutils

# tree 
install_tree() {
    brew list tree &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped tree" 
    else
        log_info "Installing tree" 
        brew install tree
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
    brew list tig &>/dev/null
    if [ $? -eq 0 ]
    then
        log_success "Skipped tig" 
    else
        log_info "Installing tig" 
        brew install tig
        if [ $? -eq 0 ]
        then
            log_success "Successfully installed tig" 
        else
            log_fail "Failed to install tig" 
        fi
    fi
}
install_tig


