clear_logo
gum style --foreground 3 --padding "1 0 0 $PADDING_LEFT" "Installing..."
echo

# Ask for sudo password once and keep the ticket alive for the rest of the install.
# All subsequent `sudo` commands in sub-scripts will use the cached credentials.
prime_sudo

start_install_log
