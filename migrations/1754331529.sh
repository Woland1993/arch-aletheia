echo "Update Waybar for new Aletheia menu"

if ! grep -q "" ~/.config/waybar/config.jsonc; then
  aletheia-refresh-waybar
fi
