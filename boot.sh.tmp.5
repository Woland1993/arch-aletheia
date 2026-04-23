#!/bin/bash

# Set install mode to online since boot.sh is used for curl installations
export ALETHEIA_ONLINE_INSTALL=true

ansi_art='   
   ▄██████▄      ███            ▄████████   ▄███████████▄   ███    ███   ▄████████      ▄███▄          ▄██████▄   
  ███    ███     ███           ███▀▀▀▀▀▀▀   ▀▀▀▀▀███▀▀▀▀▀   ███    ███  ███▀▀▀▀▀▀▀      ▀███▀         ███    ███  
  ███    ███     ███           ███               ███        ███    ███  ███              ███          ███    ███  
 ▄███▄▄▄▄███▄    ███           █████████         ███        ███▄▄▄▄███  █████████        ███         ▄███▄▄▄▄███▄ 
 ▀███▀▀▀▀███▀    ███           ███▀▀▀▀▀▀         ███        ███▀▀▀▀███  ███▀▀▀▀▀▀        ███         ▀███▀▀▀▀███▀ 
  ███    ███     ███▄▄▄▄▄▄     ███▄▄▄▄▄▄▄        ███        ███    ███  ███▄▄▄▄▄▄▄       ███          ███    ███  
  ███    ███     ▀█████████    ▀█████████        ███        ███    ███  ▀█████████      ▄███▄         ███    ███
'

clear
echo -e "\n$ansi_art\n"

# Use custom branch if instructed, otherwise default to main
ALETHEIA_REF="${ALETHEIA_REF:-main}"

# Ensure a working Arch Linux mirrorlist is in place
echo 'Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch' | sudo tee /etc/pacman.d/mirrorlist >/dev/null

sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified, otherwise default to Woland1993/arch-aletheia
ALETHEIA_REPO="${ALETHEIA_REPO:-Woland1993/arch-aletheia}"

echo -e "\nCloning Aletheia from: https://github.com/${ALETHEIA_REPO}.git"
rm -rf ~/.local/share/aletheia/
git clone "https://github.com/${ALETHEIA_REPO}.git" ~/.local/share/aletheia >/dev/null

echo -e "\e[32mUsing branch: $ALETHEIA_REF\e[0m"
cd ~/.local/share/aletheia
git fetch origin "${ALETHEIA_REF}" && git checkout "${ALETHEIA_REF}"
cd -

echo -e "\nInstallation starting..."
source ~/.local/share/aletheia/install.sh
