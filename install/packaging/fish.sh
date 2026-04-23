# Install Aletheia-fish configuration bundled under default/fish
# Replaces the former `omarchy-fish` pacman package.

FISH_SRC="$ALETHEIA_PATH/default/fish"
FISH_DEST="/usr/share/fish"

# Ensure fish is installed; it should be pulled in by aletheia-base.packages.
if ! command -v fish >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm fish
fi

# Copy vendor configs, completions and functions to the system-wide fish share
sudo mkdir -p "$FISH_DEST/vendor_conf.d" \
              "$FISH_DEST/vendor_completions.d" \
              "$FISH_DEST/vendor_functions.d"

sudo cp -r "$FISH_SRC/vendor_conf.d/."        "$FISH_DEST/vendor_conf.d/"
sudo cp -r "$FISH_SRC/vendor_completions.d/." "$FISH_DEST/vendor_completions.d/"
sudo cp -r "$FISH_SRC/vendor_functions.d/."   "$FISH_DEST/vendor_functions.d/"
