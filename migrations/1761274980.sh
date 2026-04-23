echo "Migrate to proper packages for localsend and asdcontrol"

if aletheia-pkg-present localsend-bin; then
  aletheia-pkg-drop localsend-bin
  aletheia-pkg-add localsend
fi

if aletheia-pkg-present asdcontrol-git; then
  aletheia-pkg-drop asdcontrol-git
  aletheia-pkg-add asdcontrol
fi
