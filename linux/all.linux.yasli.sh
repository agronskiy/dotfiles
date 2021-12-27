# fd
install_fd() {
    $SUDO_CMD apt-get -y install fd-find
}
exists_fd() {
   [ -x "$(command -v fdfind)" ]
}
update_fd(){
    ln -s --force $(which fdfind) "$HOME/.local/bin/fd"
}
install_wrapper "fd" install_fd exists_fd update_fd

# htop
install_htop() {
   $SUDO_CMD apt-get -y install htop
}
install_wrapper "htop" install_htop

# bat
install_batcat() {
    $SUDO_CMD apt-get -y install bat
}
exists_batcat() {
    [ -x "$(command -v batcat)" ]
}
update_batcat() {
   ln -s --force $(which batcat) "$HOME/.local/bin/bat"
}
install_wrapper "bat" install_batcat exists_batcat update_batcat


# ripgrep
install_ripgrep() {
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
    $SUDO_CMD dpkg -i ripgrep_12.1.1_amd64.deb \
    && rm ripgrep_12.1.1_amd64.deb
}
exists_ripgrep() {
    [ -x "$(command -v rg)" ]
}
install_wrapper "ripgrep" install_ripgrep exists_ripgrep

# tree
install_tree() {
   $SUDO_CMD apt-get -y install tree
}
install_wrapper "tree" install_tree

# tig
install_tig() {
   $SUDO_CMD apt-get -y install tig
}
install_wrapper "tig" install_tig

# exa
install_exa() {
    mkdir /tmp/exa-install
    (
        cd /tmp/exa-install

        if ! command -v rustc &> /dev/null
        then
            curl https://sh.rustup.rs -sSf | sh -s -- -y
        fi
        $SUDO_CMD apt-get install -y build-essential \
        && $HOME/.cargo/bin/cargo install exa \
        && cp $HOME/.cargo/bin/exa $HOME/.local/bin
    ) \
    && rm -rf /tmp/exa-install
}
exists_exa() {
    [ -x "$HOME/.local/bin" ]
}
install_wrapper "exa" install_exa exists_exa

# delta
install_delta() {
    mkdir /tmp/delta-install
    (
        cd /tmp/delta-install
        curl -LO https://github.com/dandavison/delta/releases/download/0.11.2/git-delta_0.11.2_amd64.deb \
        && $SUDO_CMD dpkg -i git-delta_0.11.2_amd64.deb
    )
    rm -rf /tmp/delta-install
}
install_wrapper "delta" install_delta

# jq
install_jq() {
    $SUDO_CMD apt-get -y install jq
}
install_wrapper "jq" install_jq

# tmux
install_tmux() {
    mkdir /tmp/tmux-install
    (
        cd /tmp/tmux-install
        $SUDO_CMD apt-get -y install autoconf automake pkg-config libevent-dev bison byacc \
        && git clone https://github.com/tmux/tmux.git \
        && cd tmux \
        && sh autogen.sh \
        && ./configure && make
    ) \
    && rm -rf /tmp/tmux-install
}
install_wrapper "tmux" install_tmux

