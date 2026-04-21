echo "Replace buggy native Zoom client with webapp"

if aletheia-pkg-present zoom; then
  aletheia-pkg-drop zoom
  aletheia-webapp-install "Zoom" https://app.zoom.us/wc/home https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/zoom.png
fi
