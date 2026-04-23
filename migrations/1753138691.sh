echo "Install swayOSD to show volume status"

if aletheia-cmd-missing swayosd-server; then
  aletheia-pkg-add swayosd
  setsid uwsm-app -- swayosd-server &>/dev/null &
fi
