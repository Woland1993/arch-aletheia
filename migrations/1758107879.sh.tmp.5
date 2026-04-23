echo "Migrate to Walker 2.0.0"

NEEDS_MIGRATION=false

PACKAGES=(
  "elephant"
  "elephant-calc"
  "elephant-clipboard"
  "elephant-bluetooth"
  "elephant-desktopapplications"
  "elephant-files"
  "elephant-menus"
  "elephant-providerlist"
  "elephant-runner"
  "elephant-symbols"
  "elephant-unicode"
  "elephant-websearch"
  "elephant-todo"
  "walker"
  "libqalculate"
)

for pkg in "${PACKAGES[@]}"; do
  if ! aletheia-pkg-present "$pkg"; then
    NEEDS_MIGRATION=true
    break
  fi
done

WALKER_MAJOR=$(walker -v 2>&1 | grep -oP '^\d+' || echo "0")
if (( WALKER_MAJOR < 2 )); then
  NEEDS_MIGRATION=true
fi

# Ensure basic config is present
mkdir -p ~/.config/walker
cp -r ~/.local/share/aletheia/config/walker/* ~/.config/walker/

if $NEEDS_MIGRATION; then
  kill -9 $(pgrep -x walker) 2>/dev/null || true

  aletheia-pkg-drop walker-bin walker-bin-debug

  aletheia-pkg-add "${PACKAGES[@]}"

  source $ALETHEIA_PATH/install/config/walker-elephant.sh

  rm -rf ~/.config/walker/themes

  aletheia-refresh-config walker/config.toml
  aletheia-refresh-config elephant/calc.toml
  aletheia-refresh-config elephant/desktopapplications.toml
fi

echo # Assure final success
