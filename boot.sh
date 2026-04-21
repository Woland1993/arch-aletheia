#!/bin/bash

# Set install mode to online since boot.sh is used for curl installations
export ALETHEIA_ONLINE_INSTALL=true

ansi_art='                 ▄▄▄
 ▄█████▄    ▄███████████▄    ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   █▀   ███   ███  ███   ███
███   ███  ███   ███   ███ ▄███▄▄▄███ ▄███▄▄▄██▀  ███       ▄███▄▄▄███▄ ███▄▄▄███
███   ███  ███   ███   ███ ▀███▀▀▀███ ▀███▀▀▀▀    ███      ▀▀███▀▀▀███  ▀▀▀▀▀▀███
███   ███  ███   ███   ███  ███   ███ ██████████  ███   █▄   ███   ███  ▄██   ███
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
 ▀█████▀    ▀█   ███   █▀   ███   █▀   ███   ███  ███████▀   ███   █▀    ▀█████▀
                                       ███   █▀                                  '

clear
echo -e "\n$ansi_art\n"

# Use custom branch if instructed, otherwise default to master
ALETHEIA_REF="${ALETHEIA_REF:-master}"

# Set mirror based on branch
if [[ $ALETHEIA_REF == "dev" ]]; then
  export ALETHEIA_MIRROR=edge
  echo 'Server = https://mirror.aletheia.org/$repo/os/$arch' | sudo tee /etc/pacman.d/mirrorlist >/dev/null
elif [[ $ALETHEIA_REF == "rc" ]]; then
  export ALETHEIA_MIRROR=rc
  echo 'Server = https://rc-mirror.aletheia.org/$repo/os/$arch' | sudo tee /etc/pacman.d/mirrorlist >/dev/null
else
  export ALETHEIA_MIRROR=stable
  echo 'Server = https://stable-mirror.aletheia.org/$repo/os/$arch' | sudo tee /etc/pacman.d/mirrorlist >/dev/null
fi

sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified, otherwise default to basecamp/aletheia
ALETHEIA_REPO="${ALETHEIA_REPO:-basecamp/aletheia}"

echo -e "\nCloning Aletheia from: https://github.com/${ALETHEIA_REPO}.git"
rm -rf ~/.local/share/aletheia/
git clone "https://github.com/${ALETHEIA_REPO}.git" ~/.local/share/aletheia >/dev/null

echo -e "\e[32mUsing branch: $ALETHEIA_REF\e[0m"
cd ~/.local/share/aletheia
git fetch origin "${ALETHEIA_REF}" && git checkout "${ALETHEIA_REF}"
cd -

echo -e "\nInstallation starting..."
source ~/.local/share/aletheia/install.sh
