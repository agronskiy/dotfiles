#!/usr/bin/env bash

install_conda() {
    if [ -x "$(command -v conda)" ]
    then
        log_success "Skipped installing conda, found already"
        exit 0
    fi

    log_info "Installing conda"

    (
        cd /tmp

        if [ -f "Miniconda3-latest-Linux-x86_64.sh" ]; then
            rm Miniconda3-latest-Linux-x86_64.sh
        fi
        curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
        chmod +x Miniconda3-latest-Linux-x86_64.sh
        # `yes` will answer to the licnese agreement.
        yes | ./Miniconda3-latest-Linux-x86_64.sh -b
        rm Miniconda3-latest-Linux-x86_64.sh
    ) 2>&1 | log_cmd

    return_val=$?
    if [ $return_val -ne 0 ]; then
        log_fail "Failed to install conda"
    else
        log_success "Installed conda"
    fi
}
install_conda

