# fd
__install_fd() {
    $SUDO_CMD apt-get -y install fd-find
}
__check_fd() {
   [ -x "$(command -v fdfind)" ]
}
__if_exists_fd(){
    ln -s --force $(which fdfind) "$HOME/.local/bin/fd"
}
install_wrapper "fd" __install_fd __check_fd __if_exists_fd

# htop
__install_htop() {
   $SUDO_CMD apt-get -y install htop
}
install_wrapper "htop" __install_htop

# bat
__install_batcat() {
    $SUDO_CMD apt-get -y install bat
}
__check_batcat() {
    [ -x "$(command -v batcat)" ]
}
__if_exists_batcat() {
   ln -s --force $(which batcat) "$HOME/.local/bin/bat"
}
install_wrapper "bat" __install_batcat __check_batcat __if_exists_batcat


# ripgrep
__install_ripgrep() {
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
    $SUDO_CMD dpkg -i ripgrep_12.1.1_amd64.deb
    rm ripgrep_12.1.1_amd64.deb
}
__check_ripgrep() {
    [ -x "$(command -v rg)" ]
}
install_wrapper "ripgrep" __install_ripgrep __check_ripgrep

# tree
__install_tree() {
   $SUDO_CMD apt-get -y install tree
}
install_wrapper "tree" __install_tree

# tig
__install_tig() {
   $SUDO_CMD apt-get -y install tig
}
install_wrapper "tig" __install_tig

# exa
__install_exa() {
    mkdir /tmp/exa-install
    (
        cd /tmp/exa-install

        if ! command -v rustc &> /dev/null
        then
            curl https://sh.rustup.rs -sSf | sh -s -- -y
        fi
        $SUDO_CMD apt-get install -y build-essential
        $HOME/.cargo/bin/cargo install exa
        cp $HOME/.cargo/bin/exa $HOME/.local/bin

        cd ~
        rm -rf /tmp/exa-install
    )
}
install_wrapper "exa" __install_exa

# delta
__install_delta() {
    mkdir /tmp/delta-install
    cd /tmp/delta-install

    curl -LO https://github.com/dandavison/delta/releases/download/0.11.2/git-delta_0.11.2_amd64.deb
    $SUDO_CMD dpkg -i git-delta_0.11.2_amd64.deb
    cd ~
    rm -rf /tmp/delta-install
}
install_wrapper "delta" __install_delta

# jq
__install_jq() {
    $SUDO_CMD apt-get -y install jq
}
install_wrapper "jq" __install_jq

# tmux
__install_tmux() {
    $SUDO_CMD apt-get -y install autoconf automake pkg-config libevent-dev bison byacc
    mkdir /tmp/tmux-install
    ( 
        cd /tmp/tmux-install
        git clone https://github.com/tmux/tmux.git && \
            cd tmux && \
            sh autogen.sh && \
            ./configure && make
    ) || return 1
    rm -rf /tmp/tmux-install
}
install_wrapper "tmux" __install_tmux

