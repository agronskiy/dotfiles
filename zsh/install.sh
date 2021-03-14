#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

if ! [ -x "$(command -v fzf)" ]
then
    log_info "Installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" && "$HOME/.fzf/install"
    return_val=$?

    if [ $return_val -ne 0 ]; then
        log_fail "Failed to install fzf"
    else
        log_success "Installed fzf"
    fi
else
    log_info "Skipped installing fzf"
fi

# zsh completions
install_zsh_completions() {
    if [ ! -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-completions ]
    then
        mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-completions
        log_success "Cloned zsh-completions"
    else
        (
            cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-completions
            git pull &> /dev/null
            if [ $? -eq 0 ]; then
                log_success "Pulled zsh-completions"
            else
                log_fail "Error pulling zsh-completions"
            fi
        )
    fi
}

# Conda completions, see https://github.com/esc/conda-zsh-completion/blob/master/_conda
install_conda_completions() {
    if [ ! -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/conda-zsh-completion ]
    then
        mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
        git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/conda-zsh-completion
        log_success "Cloned conda-zsh-completion"
    else
        (
            cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/conda-zsh-completion
            git pull &> /dev/null
            if [ $? -eq 0 ]; then
                log_success "Pulled conda-zsh-completion"
            else
                log_fail "Error pulling conda-zsh-completion"
            fi
        )
    fi
}
install_conda_completions
