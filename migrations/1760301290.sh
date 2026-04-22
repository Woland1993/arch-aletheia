echo "Add the new Flexoki Light theme"

if [[ ! -L ~/.config/aletheia/themes/flexoki-light ]]; then
  ln -nfs ~/.local/share/aletheia/themes/flexoki-light ~/.config/aletheia/themes/
fi
