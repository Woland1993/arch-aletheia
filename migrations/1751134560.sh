echo "Add UWSM env"

export ALETHEIA_PATH="$HOME/.local/share/aletheia"
export PATH="$ALETHEIA_PATH/bin:$PATH"

mkdir -p "$HOME/.config/uwsm/"
cat <<EOF | tee "$HOME/.config/uwsm/env"
export ALETHEIA_PATH=$HOME/.local/share/aletheia
export PATH=$ALETHEIA_PATH/bin/:$PATH
EOF

# Ensure we have the latest repos and are ready to pull
aletheia-update-keyring
aletheia-refresh-pacman
sudo systemctl restart systemd-timesyncd
sudo pacman -Sy # Normally not advisable, but we'll do a full -Syu before finishing

mkdir -p ~/.local/state/aletheia/migrations
touch ~/.local/state/aletheia/migrations/1751134560.sh

# Remove old AUR packages to prevent a super lengthy build on old Aletheia installs
aletheia-pkg-drop zoom qt5-remoteobjects wf-recorder wl-screenrec

# Get rid of old AUR packages
bash $ALETHEIA_PATH/migrations/1756060611.sh
touch ~/.local/state/aletheia/migrations/1756060611.sh

bash aletheia-update-perform
