echo "Switch back to mainline chromium now that it supports full live themeing"

if aletheia-pkg-present aletheia-chromium; then
  if gum confirm "Ready to switch to mainstream chromium? (Will close Chromium + reset settings)"; then
    pkill -x chromium
    aletheia-pkg-drop aletheia-chromium
    aletheia-pkg-add chromium
    aletheia-theme-set-browser
  fi
fi
