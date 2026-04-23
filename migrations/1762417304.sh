echo "Replace bluetooth GUI with TUI"

aletheia-pkg-add bluetui
aletheia-pkg-drop blueberry

if ! grep -q "aletheia-launch-bluetooth" ~/.config/waybar/config.jsonc; then
  sed -i 's/blueberry/aletheia-launch-bluetooth/' ~/.config/waybar/config.jsonc
fi
