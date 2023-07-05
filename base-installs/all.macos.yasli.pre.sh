#!/usr/bin/env bash
#
# Basic installs

if ! [ -x "$(command -v curl)" ]
then
    log_fail "CURL MISSING"
fi

if ! [ -x "$(command -v brew)" ]
then
    log_info "  Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" |
        log_cmd
    if [ $? -eq 0 ] ; then
        log_success "Successfully installed brew"
    else
        log_fail "Failed to install brew"
    fi
# brew update is currently broken, TODO: retrun it back
# else
#     log_info "Updating brew"
#     brew update 2>&1 | log_cmd
#     if [ $? -eq 0 ] ; then
#         log_success "Successfully updated brew"
#     else
#         log_fail "Failed to update brew"
#     fi
fi

