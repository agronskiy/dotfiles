install_local_bin_dir() {
    mkdir -p "$HOME/.local/bin"
}
exists_local_bin_dir() {
    [ -d "$HOME/.local/bin"]
}
install_wrapper "local bin directory" install_local_bin_dir exists_local_bin_dir
