echo "Add right-click terminal action to waybar aletheia menu icon"

WAYBAR_CONFIG="$HOME/.config/waybar/config.jsonc"

if [[ -f $WAYBAR_CONFIG ]] && ! grep -A5 '"custom/aletheia"' "$WAYBAR_CONFIG" | grep -q '"on-click-right"'; then
  sed -i '/"on-click": "aletheia-menu",/a\    "on-click-right": "aletheia-launch-terminal",' "$WAYBAR_CONFIG"
fi
