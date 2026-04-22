echo "Use explicit timezone selector when right-clicking on clock"

sed -i 's/aletheia-cmd-tzupdate/aletheia-launch-floating-terminal-with-presentation aletheia-tz-select/g' ~/.config/waybar/config.jsonc
