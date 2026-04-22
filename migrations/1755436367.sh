echo "Add minimal starship prompt to terminal"

if aletheia-cmd-missing starship; then
  aletheia-pkg-add starship
  cp $ALETHEIA_PATH/config/starship.toml ~/.config/starship.toml
fi
