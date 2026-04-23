echo "Add opencode with system themeing"

aletheia-pkg-add opencode

# Add config using aletheia theme by default
if [[ ! -f ~/.config/opencode/opencode.json ]]; then
  mkdir -p ~/.config/opencode
  cp $ALETHEIA_PATH/config/opencode/opencode.json ~/.config/opencode/opencode.json
fi
