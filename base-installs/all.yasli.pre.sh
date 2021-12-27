install_local_bin_dir() {
    mkdir -p "$HOME/.local/bin"
}
exists_local_bin_dir() {
    [ -d "$HOME/.local/bin" ]
}
install_wrapper "local bin directory" install_local_bin_dir exists_local_bin_dir

install_home_bin_dir() {
    mkdir -p "$HOME/bin"
}
exists_home_bin_dir() {
    [ -d "$HOME/bin" ]
}
install_wrapper "home bin directory" install_home_bin_dir exists_home_bin_dir
