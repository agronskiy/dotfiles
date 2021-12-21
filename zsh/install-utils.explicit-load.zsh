source $DOTFILES/zsh/logging.explicit-load.zsh

install_wrapper() {
  # $1 command name
  # $2 function name which does installation
  if [ -x "$(command -v $1)" ]; then
    log_success "Skipped $1 (already installed)"
  else
    log_info "Installing $1"
    $2 2>&1 | log_cmd || log_fail "Failed to install $1"
    log_success "Successfully installed $1"
  fi
}

install_wrapper_with_checker() {
  # $1 command name
  # $2 function name which does installation
  # $3 checker that the tool exists
  if $3; then
    log_success "Skipped $1 (already installed)"
  else
    log_info "Installing $1"
    $2 2>&1 | log_cmd || log_fail "Failed to install $1"
    log_success "Successfully installed $1"
  fi
}
