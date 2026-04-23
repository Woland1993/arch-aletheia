# Handles changes since 3.1.0-RC

echo "Add shift+insert for kitty"
# Add shift+insert paste keybinding to kitty.conf if it doesn't exist
KITTY_CONF="$HOME/.config/kitty/kitty.conf"

if ! grep -q "map shift+insert paste_from_clipboard" "$KITTY_CONF"; then
  sed -i '/map ctrl+insert copy_to_clipboard/a map shift+insert paste_from_clipboard' "$KITTY_CONF"
fi

echo "Copy hooks examples"
cp -r $ALETHEIA_PATH/config/aletheia/* $HOME/.config/aletheia/

echo "Add packages for updated aletheia-cmd-screenshot"
aletheia-pkg-add grim slurp

echo "Add nfs support by default to Nautilus"
aletheia-pkg-add gvfs-nfs

if [[ ! -d $HOME/.config/nvim ]]; then
  echo "Add missing nvim config"
  aletheia-nvim-setup
fi