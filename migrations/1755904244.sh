echo "Update fastfetch config with new Aletheia logo"

aletheia-refresh-config fastfetch/config.jsonc

mkdir -p ~/.config/aletheia/branding
cp $ALETHEIA_PATH/icon.txt ~/.config/aletheia/branding/about.txt
