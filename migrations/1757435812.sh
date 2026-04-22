echo "Update Zoom webapp to handle zoommtg:// and zoomus:// protocol links"

if [[ -f ~/.local/share/applications/Zoom.desktop ]]; then
  aletheia-webapp-remove Zoom
  aletheia-webapp-install Zoom https://app.zoom.us/wc/home Zoom.png "aletheia-webapp-handler-zoom %u" "x-scheme-handler/zoommtg;x-scheme-handler/zoomus"
fi
