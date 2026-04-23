echo "Add Catppuccin Latte light theme"

if [[ ! -L $HOME/.config/aletheia/themes/catppuccin-latte ]]; then
  ln -snf ~/.local/share/aletheia/themes/catppuccin-latte ~/.config/aletheia/themes/
fi
