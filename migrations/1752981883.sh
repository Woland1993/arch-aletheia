echo "Replace wofi with walker as the default launcher"

if aletheia-cmd-missing walker; then
  aletheia-pkg-add walker-bin libqalculate

  aletheia-pkg-drop wofi
  rm -rf ~/.config/wofi

  mkdir -p ~/.config/walker
  cp -r ~/.local/share/aletheia/config/walker/* ~/.config/walker/
fi
