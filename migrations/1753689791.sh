echo "Add the new ristretto theme as an option"

if [[ ! -L ~/.config/aletheia/themes/ristretto ]]; then
  ln -nfs ~/.local/share/aletheia/themes/ristretto ~/.config/aletheia/themes/
fi
