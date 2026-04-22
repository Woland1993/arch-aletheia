# Install yay AUR helper if not already installed
if ! command -v yay &>/dev/null; then
  echo "Installing yay AUR helper..."
  tmpdir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  cd "$tmpdir/yay"
  makepkg -si --noconfirm
  cd -
  rm -rf "$tmpdir"
fi
