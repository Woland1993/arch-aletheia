echo "Add new matte black theme"

if [[ ! -L $HOME/.config/aletheia/themes/matte-black ]]; then
  ln -snf ~/.local/share/aletheia/themes/matte-black ~/.config/aletheia/themes/
fi
