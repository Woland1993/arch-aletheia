# Install Aletheia-zsh configuration bundled under default/zsh
# Replaces the former `omarchy-zsh` pacman package.

ZSH_SRC="$ALETHEIA_PATH/default/zsh"
ZSH_DEST="/usr/share/aletheia-zsh"

# Ensure zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm zsh
fi

sudo mkdir -p "$ZSH_DEST/shell" "$ZSH_DEST/templates"
sudo cp -r "$ZSH_SRC/shell/."     "$ZSH_DEST/shell/"
sudo cp -r "$ZSH_SRC/templates/." "$ZSH_DEST/templates/"
