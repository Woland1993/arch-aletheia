echo "Make ethereal available as new theme"

if [[ ! -L ~/.config/aletheia/themes/ethereal ]]; then
  rm -rf ~/.config/aletheia/themes/ethereal
  ln -nfs ~/.local/share/aletheia/themes/ethereal ~/.config/aletheia/themes/
fi
