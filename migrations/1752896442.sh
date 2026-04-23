echo "Replace volume control GUI with a TUI"

if aletheia-cmd-missing wiremix; then
  aletheia-pkg-add wiremix
  aletheia-pkg-drop pavucontrol
  aletheia-refresh-applications
  aletheia-refresh-waybar
fi
