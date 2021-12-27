
if ! [ -x "$(command -v curl)" ]
then
    log_info "Installing cURL"
    $SUDO_CMD apt-get -y install curl 2>&1 | log_cmd
    if [ $? -eq 0 ] ; then
        log_success "Successfully installed cURL"
    else
        log_fail "Failed to install cURL"
    fi
else
    log_success "Skipped curl"
fi

if ! [ -x "$(command -v brew)" ]
then
    log_info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 2>&1 |
        log_cmd

    if [ $? -eq 0 ] ; then
        log_success "Successfully installed brew"
    else
        log_fail "Failed to install brew"
    fi
else
    log_success "Skipped brew"
fi
