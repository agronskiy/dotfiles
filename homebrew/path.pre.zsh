# Set up linuxbrew if available (user or linuxbrew)
if [[ -d "$HOME/.linuxbrew" ]]; then
  export PATH="$HOME.linuxbrew/bin:$PATH"
fi

if [[ -d "/home/linuxbrew//.linuxbrew" ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
