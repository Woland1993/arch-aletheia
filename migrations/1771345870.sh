echo "Switch lmstudio -> lmstudio-bin"

if pacman -Q lmstudio &>/dev/null; then
  aletheia-pkg-drop lmstudio
  aletheia-pkg-add lmstudio-bin
fi
