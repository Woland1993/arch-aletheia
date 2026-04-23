# Ask the user for their sudo password ONCE at the start of the install,
# then keep the sudo ticket alive in the background so subsequent `sudo`
# commands in any sub-script never re-prompt.
#
# We intentionally do NOT store the password in a variable, file, or env
# — sudo itself caches the auth ticket for us, which is the safe approach.

SUDO_KEEPALIVE_PID=""

prime_sudo() {
  # Skip if we're already root (e.g. inside chroot)
  if (( EUID == 0 )); then
    return 0
  fi

  # Prompt once, up front, with a clear message
  echo
  echo -e "\e[33mAletheia needs sudo access to install packages and configure the system.\e[0m"
  echo -e "\e[33mYou will be asked for your password ONCE; it will be cached for the rest of the install.\e[0m"
  echo

  if ! sudo -v; then
    echo -e "\e[31mCould not obtain sudo credentials. Aborting.\e[0m"
    exit 1
  fi

  # Refresh the sudo timestamp every 60s in the background so it never
  # expires during long package installs. The loop exits automatically
  # when the parent shell dies (kill -0 $$ returns non-zero).
  (
    while true; do
      sleep 60
      sudo -n -v 2>/dev/null || exit 0
      kill -0 "$PPID" 2>/dev/null || exit 0
    done
  ) &
  SUDO_KEEPALIVE_PID=$!
  disown "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
  export SUDO_KEEPALIVE_PID
}

stop_sudo_keepalive() {
  if [[ -n ${SUDO_KEEPALIVE_PID:-} ]]; then
    kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
    wait "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
    unset SUDO_KEEPALIVE_PID
  fi
}
