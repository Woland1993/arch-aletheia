# Bootstrap yay (AUR helper) if not already installed.
# yay itself is an AUR package, so we build it from source via makepkg.
# After this runs, aletheia-pkg-add can install any AUR package.

if command -v yay &>/dev/null; then
  exit 0
fi

echo "Bootstrapping yay from AUR..."

# base-devel + git are required to build AUR packages via makepkg.
# base-devel is installed earlier in preflight/pacman.sh, git in boot.sh.
sudo pacman -S --noconfirm --needed base-devel git

# Build yay-bin (prebuilt binary variant — much faster than compiling yay from Go source)
BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT

git clone --depth=1 https://aur.archlinux.org/yay-bin.git "$BUILD_DIR/yay-bin"
cd "$BUILD_DIR/yay-bin"
makepkg -si --noconfirm
cd -

# Verify
if ! command -v yay &>/dev/null; then
  echo "Error: yay bootstrap failed" >&2
  exit 1
fi

echo "yay installed successfully: $(yay --version | head -1)"
