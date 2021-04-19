#!/usr/bin/env bash

source $DOTFILES/zsh/logging.explicit-load.zsh

install_fzf () {
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
}
install_fzf

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
install_zsh_completions

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

# fzf tab completions
install_fzf_tab() {
    if [ ! -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/fzf-tab ]
    then
        mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
        git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/fzf-tab
        log_success "Cloned fzf-tab-completions"
    else
        (
            cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/fzf-tab
            git pull &> /dev/null
            if [ $? -eq 0 ]; then
                log_success "Pulled fzf-tab-completions"
            else
                log_fail "Error pulling fzf-tab-completions"
            fi
        )
    fi
}
install_fzf_tab


# zsh_syntax_highlight
install_zsh_syntax_highlight() {
    if [ ! -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-syntax-highlighting ]
    then
        mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-syntax-highlighting
        log_success "Cloned zsh-syntax-highlighting"
    else
        (
            cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-syntax-highlighting
            git pull &> /dev/null
            if [ $? -eq 0 ]; then
                log_success "Pulled zsh-syntax-highlighting"
            else
                log_fail "Error pulling zsh-syntax-highlighting"
            fi
        )
    fi
}
install_zsh_syntax_highlight
