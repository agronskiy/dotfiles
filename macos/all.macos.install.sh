#!/usr/bin/env bash

# fd
install_fd() {
   if brew list fd &>/dev/null; then
        log_success "Skipped fd"
    else
        log_info "Installing fd"
        brew install fd 2>&1 | log_cmd ||
            log_fail "Failed to install fd"
        log_success "Successfully installed fd"
    fi
}
install_fd

# htop
install_htop() {
    if brew list htop &>/dev/null; then
        log_success "Skipped htop"
    else
        log_info "Installing htop"
        brew install htop 2>&1 | log_cmd ||
            log_fail "Failed to install htop"
        log_success "Successfully installed htop"
    fi
}
install_htop


# bat
install_bat() {
    if brew list bat &>/dev/null; then
        log_success "Skipped bat"
    else
        log_info "Installing bat"
        brew install bat 2>&1 | log_cmd ||
            log_fail "Failed to install bat"
        log_success "Successfully installed bat"
    fi
}
install_bat

# ripgrep
install_ripgrep() {
    if brew list ripgrep &>/dev/null; then
        log_success "Skipped ripgrep"
    else
        log_info "Installing ripgrep"
        brew install ripgrep 2>&1 | log_cmd ||
            log_fail "Failed to install ripgrep"
        log_success "Successfully installed ripgrep"
    fi
}
install_ripgrep

# coreutils
install_coreutils() {
    if brew list coreutils &>/dev/null; then
        log_success "Skipped coreutils"
    else
        log_info "Installing coreutils"
        brew install coreutils 2>&1 | log_cmd ||
            log_fail "Failed to install coreutils"
        log_success "Successfully installed coreutils"fi
    fi
}
install_coreutils

# tree
install_tree() {
    if brew list tree &>/dev/null; then
        log_success "Skipped tree"
    else
        log_info "Installing tree"
        brew install tree 2>&1 | log_cmd ||
            log_fail "Failed to install tree"
        log_success "Successfully installed tree"
    fi
}
install_tree

# tig
install_tig() {
    if brew list tig &>/dev/null; then
        log_success "Skipped tig"
    else
        log_info "Installing tig"
        brew install tig 2>&1 | log_cmd ||
            log_fail "Failed to install tig"
        log_success "Successfully installed tig"
    fi
}
install_tig

# exa
install_exa() {
   if brew list exa &>/dev/null; then
        log_success "Skipped exa"
    else
        log_info "Installing exa"
        brew install exa 2>&1 | log_cmd ||
            log_fail "Failed to install exa"
        log_success "Successfully installed exa"
    fi
}
install_exa

# delta
install_delta() {
    if brew list git-delta &>/dev/null; then
        log_success "Skipped delta"
    else
        log_info "Installing delta"
        brew install git-delta 2>&1 | log_cmd ||
            log_fail "Failed to install delta"
        log_success "Successfully installed delta"
    fi
}
install_delta

# jq
install_jq() {
    if brew list jq &>/dev/null; then
        log_success "Skipped jq"
    else
        log_info "Installing jq"
        brew install jq 2>&1 | log_cmd ||
            log_fail "Failed to install jq"
        log_success "Successfully installed jq"
    fi
}
install_jq
