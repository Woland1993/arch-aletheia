# Install aletheia SDDM theme if available
if [[ -d $ALETHEIA_PATH/default/sddm/aletheia ]]; then
  aletheia-refresh-sddm
fi

# Detect available Hyprland session
if [[ -f /usr/share/wayland-sessions/hyprland-uwsm.desktop ]]; then
  HYPR_SESSION="hyprland-uwsm"
elif [[ -f /usr/share/wayland-sessions/hyprland.desktop ]]; then
  HYPR_SESSION="hyprland"
else
  HYPR_SESSION="hyprland"
fi

# Setup SDDM login service
sudo mkdir -p /etc/sddm.conf.d
if [[ ! -f /etc/sddm.conf.d/autologin.conf ]]; then
  cat <<EOF | sudo tee /etc/sddm.conf.d/autologin.conf
[Autologin]
User=$USER
Session=$HYPR_SESSION

[Theme]
Current=aletheia
EOF
fi

# Prevent password-based SDDM logins from creating an encrypted login keyring
# (which conflicts with the passwordless Default_keyring used for auto-unlock)
sudo sed -i '/-auth.*pam_gnome_keyring\.so/d' /etc/pam.d/sddm
sudo sed -i '/-password.*pam_gnome_keyring\.so/d' /etc/pam.d/sddm

# Don't use chrootable here as --now will cause issues for manual installs
sudo systemctl enable sddm.service
