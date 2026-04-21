echo "Install Impala as new wifi selection TUI"

if aletheia-cmd-missing impala; then
  aletheia-pkg-add impala
  aletheia-refresh-waybar
fi
