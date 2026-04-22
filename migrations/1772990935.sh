echo "Add sample low battery notification hook"

mkdir -p ~/.config/aletheia/hooks

if [[ ! -f ~/.config/aletheia/hooks/battery-low.sample ]]; then
  cp "$ALETHEIA_PATH/config/aletheia/hooks/battery-low.sample" ~/.config/aletheia/hooks/battery-low.sample
fi
