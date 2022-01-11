
if ! [ -x "$(command -v curl)" ]
then
    log_info "Installing cURL"
    $SUDO_CMD apt-get -y install curl 2>&1 | log_cmd
    if [ $? -eq 0 ] ; then
        log_success "Successfully installed cURL"
    else
        log_fail "Failed to install cURL"
    fi
else
    log_success "Skipped curl"
fi

install_build_essential() {
    $SUDO_CMD apt-get -y install build-essential
}
exists_build_essential() {
    dpkg-query -W -f='${Status}' build-essential | grep "ok installed" > /dev/null
}
install_wrapper "build-essentials" install_build_essential exists_build_essential
