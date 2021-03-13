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
