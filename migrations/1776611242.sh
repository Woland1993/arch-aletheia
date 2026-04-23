echo "Install socat so we can reactivate internal display when external display is removed"

aletheia-pkg-add socat
uwsm-app -- aletheia-hyprland-monitor-watch &
