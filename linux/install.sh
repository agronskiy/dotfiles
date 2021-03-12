#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

if ! [ "$(uname -s)" == "Linux" ]; then
    log_success "Skipped linux-specific stuff"
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
