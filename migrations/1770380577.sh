echo "Use interactive background selector menu"

mkdir -p ~/.config/elephant/menus
ln -snf $ALETHEIA_PATH/default/elephant/aletheia_background_selector.lua ~/.config/elephant/menus/aletheia_background_selector.lua
aletheia-restart-walker
