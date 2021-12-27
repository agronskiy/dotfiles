#!/usr/bin/env bash

# Below, there're plugins that rely on
[ -z $ZSH ] && { log_info "ZSH not set, assuming ~/.oh-my-zsh"; ZSH=$HOME/.oh-my-zsh; }

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
        && export ZSH=$HOME/.oh-my-zsh
}
exists_oh_my_zsh() {
    [ ! -z $ZSH ]
}
install_wrapper "oh-my-zsh" \
    install_oh_my_zsh \
    exists_oh_my_zsh

install_fzf() {
    rm -rf "$HOME/.fzf" || true
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" \
        && "$HOME/.fzf/install"
}
install_wrapper "fzf" install_fzf

# zsh completions
install_zsh_completions() {
    mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-completions
}
exists_zsh_completions() {
    [ -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-completions ]
}
update_zsh_completions() {
    ( cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-completions \
        && git pull &> /dev/null )
}
install_wrapper "zsh-completions" \
    install_zsh_completions \
    exists_zsh_completions \
    update_zsh_completions

# conda completions
install_conda_completions() {
    mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
    git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/conda-zsh-completion
}
exists_conda_completions() {
    [ -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/conda-zsh-completion ]
}
update_conda_completions() {
    ( cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/conda-zsh-completion \
        && git pull &> /dev/null )
}
install_wrapper "conda-completions" install_conda_completions exists_conda_completions update_conda_completions


# fzf tab completions
install_fzf_tab() {
    mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
    git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/fzf-tab
}
exists_fzf_tab () {
    [ -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/fzf-tab ]
}
update_fzf_tab () {
    ( cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/fzf-tab \
        && git pull &> /dev/null )
}
install_wrapper "fzf-tab completions" \
    install_fzf_tab \
    exists_fzf_tab \
    update_fzf_tab


# zsh_syntax_highlight
install_zsh_syntax_highlight() {
    mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
    git clone \
        https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-syntax-highlighting
}
exists_zsh_syntax_highlight () {
    [ -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-syntax-highlighting ]
}
update_zsh_syntax_highlight () {
    ( cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-syntax-highlighting \
        && git pull &> /dev/null )
}
install_wrapper "zsh syntax highlighting" \
    install_zsh_syntax_highlight \
    exists_zsh_syntax_highlight \
    update_zsh_syntax_highlight


# zsh_autosuggestions
install_zsh_autosuggestions() {
    mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
    git clone https://github.com/zsh-users/zsh-autosuggestions \
            ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}
exists_zsh_autosuggestions () {
    [ -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-autosuggestions ]
}
update_zsh_autosuggestions () {
    ( cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-autosuggestions \
        && git pull &> /dev/null )
}
install_wrapper "zsh autosuggestions" \
    install_zsh_autosuggestions \
    exists_zsh_autosuggestions \
    update_zsh_autosuggestions
