#!/usr/bin/env bash

# fd
install_fd() {
    $SUDO_CMD apt-get -y install fd-find
}
exists_fd() {
   [ -x "$(command -v fdfind)" ]
}
update_fd(){
    ln -s --force "$(which fdfind)" "$HOME/.local/bin/fd"
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
   ln -s --force "$(which batcat)" "$HOME/.local/bin/bat"
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
    [ -d /tmp/exa-install ] && rm -rf /tmp/exa-install
    mkdir /tmp/exa-install
    (
        cd /tmp/exa-install

        if ! command -v rustc &> /dev/null
        then
            curl https://sh.rustup.rs -sSf | sh -s -- -y
        fi

        # Install
        $SUDO_CMD apt-get install -y build-essential \
        && $HOME/.cargo/bin/cargo install exa \
        && cp $HOME/.cargo/bin/exa $HOME/.local/bin
    ) \
    && rm -rf /tmp/exa-install
}
exists_exa() {
    [ -x "$HOME/.local/bin/exa" ]
}
install_wrapper "exa" install_exa exists_exa

# delta
install_delta() {
    [ -d /tmp/delta-install ] && rm -rf /tmp/delta-install
    mkdir /tmp/delta-install
    (
        cd /tmp/delta-install
        curl -LO https://github.com/dandavison/delta/releases/download/0.11.2/git-delta_0.11.2_amd64.deb \
        && $SUDO_CMD dpkg -i git-delta_0.11.2_amd64.deb
    ) \
    && rm -rf /tmp/delta-install
}
install_wrapper "delta" install_delta

# jq
install_jq() {
    $SUDO_CMD apt-get -y install jq
}
install_wrapper "jq" install_jq

# tmux
install_tmux() {
    [ -d /tmp/tmux-install ] && rm -rf /tmp/tmux-install
    mkdir /tmp/tmux-install
    (
        cd /tmp/tmux-install
        $SUDO_CMD apt-get -y install libncurses5-dev libncursesw5-dev autoconf automake pkg-config libevent-dev bison byacc \
        && git clone https://github.com/tmux/tmux.git \
        && cd tmux \
        && sh autogen.sh \
        && ./configure \
        && make \
        && $SUDO_CMD make install
    ) \
    && rm -rf /tmp/tmux-install
}
install_wrapper "tmux" install_tmux

# neovim
install_neovim() {
    [ -d "$HOME/.local/bin/neovim-install" ] && rm -rf "$HOME/.local/bin/neovim-install"
    mkdir -p "$HOME/.local/bin/neovim-install"
    cd $HOME/.local/bin/neovim-install \
    && curl -LO https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz \
    && tar xzvf nvim-linux64.tar.gz \
    && ln -s --force "$(realpath ./nvim-linux64/bin/nvim)" "$HOME/.local/bin/nvim"
}
exists_neovim() {
  [ -x "$(command -v nvim)" ] && nvim --version | grep -q "0.10.2"
}
install_wrapper "neovim" install_neovim exists_neovim

# nodejs
install_nodejs() {
    $SUDO_CMD apt-get -y install nodejs
}
exists_nodejs() {
    [ -x "$(command -v node)" ]
}
install_wrapper "nodejs" install_nodejs exists_nodejs

# shellcheck
install_shellcheck() {
  $SUDO_CMD apt install shellcheck
}
exists_shellcheck() {
    [ -x "$(command -v shellcheck)" ]
}
install_wrapper "shellcheck" install_shellcheck exists_shellcheck

# lazygit
install_lazygit() {
    [ -d "$HOME/.local/bin/lazygit-install" ] && rm -rf "$HOME/.local/bin/lazygit-install"
    mkdir -p "$HOME/.local/bin/lazygit-install"
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
    cd $HOME/.local/bin/lazygit-install \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
    && $SUDO_CMD tar xf lazygit.tar.gz -C "$HOME/.local/bin" lazygit \
    && rm -rf lazygit.tar.gz
}
exists_lazygit() {
  [ -x "$(command -v lazygit)" ]
}
install_wrapper "lazygit" install_lazygit exists_lazygit

# install k9s
install_k9s() {
  curl -sS https://webinstall.dev/k9s | bash
}
exists_k9s() {
    [ -x "$(command -v k9s)" ]
}
install_wrapper "k9s" install_k9s exists_k9s

# install pynvim
install_pynvim() {
    sys_python=$(which -a python3 | head -n2 | tail -n1)
    $SUDO_CMD $sys_python -m pip install pynvim 
}
exists_pynvim() {
    sys_python=$(which -a python3 | head -n2 | tail -n1)
    $sys_python -c 'import pynvim'
}
install_wrapper "pynvim" install_pynvim exists_pynvim

