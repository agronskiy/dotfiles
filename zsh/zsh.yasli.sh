#!/usr/bin/env bash

# Below, there're plugins that rely on
[ -z $ZSH ] && { log_info "ZSH not set, assuming ~/.oh-my-zsh"; export ZSH=$HOME/.oh-my-zsh; }

install_oh_my_zsh() {
    [ ! -z $ZSH ] && [ -d $ZSH ] && rm -rf $ZSH
    echo "no" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
        && export ZSH=$HOME/.oh-my-zsh \
        && (
            [ -f $HOME/.zshrc.pre-oh-my-zsh ] && mv $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc || true
        )
}
exists_oh_my_zsh() {
    [ ! -z $ZSH ] && [ -d $ZSH ]
}
install_wrapper "oh-my-zsh" \
    install_oh_my_zsh \
    exists_oh_my_zsh

# fzf
install_fzf() {
    rm -rf "$HOME/.fzf" || true
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" \
        && "$HOME/.fzf/install" --key-bindings --completion --no-update-rc
}
exists_fzf() {
    [ -x "$HOME/.fzf/bin/fzf" ]
}
install_wrapper "fzf" install_fzf exists_fzf

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
    [ -d "${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-autosuggestions" ]
}
update_zsh_autosuggestions () {
    ( cd "${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-autosuggestions" \
        && git pull &> /dev/null )
}
install_wrapper "zsh autosuggestions" \
    install_zsh_autosuggestions \
    exists_zsh_autosuggestions \
    update_zsh_autosuggestions

# zsh_kube_ps1
install_zsh_kube_ps1() {
    mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
    git clone \
        https://github.com/jonmosco/kube-ps1 \
        ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/kube-ps1
}
exists_zsh_kube_ps1 () {
    [ -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/kube-ps1 ]
}
update_zsh_kube_ps1 () {
    ( cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/kube-ps1 \
        && git pull &> /dev/null )
}
install_wrapper "zsh kube_ps1" \
    install_zsh_kube_ps1 \
    exists_zsh_kube_ps1 \
    update_zsh_kube_ps1

# zsh_no_ps
install_zsh_no_ps2() {
    mkdir -p ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/
    git clone \
        https://github.com/romkatv/zsh-no-ps2.git \
        ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-no-ps2
}
exists_zsh_no_ps2 () {
    [ -d ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-no-ps2 ]
}
update_zsh_no_ps2 () {
    ( cd ${ZSH_CUSTOM:=${ZSH}/custom}/plugins/zsh-no-ps2 \
        && git pull &> /dev/null )
}
install_wrapper "zsh no ps2" \
    install_zsh_no_ps2 \
    exists_zsh_no_ps2 \
    update_zsh_no_ps2


