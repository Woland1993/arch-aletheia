echo "Link new theme picker config"

mkdir -p ~/.config/elephant/menus
ln -snf $ALETHEIA_PATH/default/elephant/aletheia_themes.lua ~/.config/elephant/menus/aletheia_themes.lua
sed -i '/"menus",/d' ~/.config/walker/config.toml
aletheia-restart-walker
