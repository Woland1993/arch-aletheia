if command -v limine &>/dev/null; then
  # Try to install limine helper packages, but don't fail if unavailable
  sudo pacman -S --noconfirm --needed limine-snapper-sync limine-mkinitcpio-hook 2>/dev/null || \
    echo "Warning: limine-snapper-sync or limine-mkinitcpio-hook not available, skipping"

  sudo tee /etc/mkinitcpio.conf.d/aletheia_hooks.conf <<EOF >/dev/null
HOOKS=(base udev plymouth keyboard autodetect microcode modconf kms keymap consolefont block encrypt filesystems fsck btrfs-overlayfs)
EOF
  sudo tee /etc/mkinitcpio.conf.d/thunderbolt_module.conf <<EOF >/dev/null
MODULES+=(thunderbolt)
EOF

  # Detect boot mode
  [[ -d /sys/firmware/efi ]] && EFI=true

  # Find config location
  if [[ -f /boot/EFI/arch-limine/limine.conf ]]; then
    limine_config="/boot/EFI/arch-limine/limine.conf"
  elif [[ -f /boot/EFI/BOOT/limine.conf ]]; then
    limine_config="/boot/EFI/BOOT/limine.conf"
  elif [[ -f /boot/EFI/limine/limine.conf ]]; then
    limine_config="/boot/EFI/limine/limine.conf"
  elif [[ -f /boot/limine/limine.conf ]]; then
    limine_config="/boot/limine/limine.conf"
  elif [[ -f /boot/limine.conf ]]; then
    limine_config="/boot/limine.conf"
  else
    echo "Warning: Limine config not found, skipping limine configuration"
    exit 0
  fi

  CMDLINE=$(grep "^[[:space:]]*cmdline:" "$limine_config" | head -1 | sed 's/^[[:space:]]*cmdline:[[:space:]]*//')

  if [[ -f $ALETHEIA_PATH/default/limine/default.conf ]]; then
    sudo cp $ALETHEIA_PATH/default/limine/default.conf /etc/default/limine
    sudo sed -i "s|@@CMDLINE@@|$CMDLINE|g" /etc/default/limine

    # Append any drop-in kernel cmdline configs (from hardware fix scripts, etc.)
    for dropin in /etc/limine-entry-tool.d/*.conf; do
      [ -f "$dropin" ] && cat "$dropin" | sudo tee -a /etc/default/limine >/dev/null
    done

    # UKI and EFI fallback are EFI only
    if [[ -z ${EFI:-} ]]; then
      sudo sed -i '/^ENABLE_UKI=/d; /^ENABLE_LIMINE_FALLBACK=/d' /etc/default/limine
    fi
  fi

  # Remove the original config file if it's not /boot/limine.conf
  if [[ $limine_config != "/boot/limine.conf" ]] && [[ -f $limine_config ]]; then
    sudo rm "$limine_config"
  fi

  # We overwrite the whole thing knowing the limine-update will add the entries for us
  if [[ -f $ALETHEIA_PATH/default/limine/limine.conf ]]; then
    sudo cp $ALETHEIA_PATH/default/limine/limine.conf /boot/limine.conf
  fi

  # Configure Snapper only if snapper is available and filesystem is BTRFS
  if command -v snapper &>/dev/null && [[ $(findmnt -n -o FSTYPE /) == "btrfs" ]]; then
    # Match Snapper configs if not installing from the ISO
    if [[ -z ${ALETHEIA_CHROOT_INSTALL:-} ]]; then
      if ! sudo snapper list-configs 2>/dev/null | grep -q "root"; then
        sudo snapper -c root create-config / || echo "Warning: failed to create snapper root config"
      fi

      if ! sudo snapper list-configs 2>/dev/null | grep -q "home"; then
        sudo snapper -c home create-config /home || echo "Warning: failed to create snapper home config"
      fi
    fi

    # Enable quota to allow space-aware algorithms to work
    sudo btrfs quota enable / 2>/dev/null || true

    # Tweak default Snapper configs (only if they exist)
    if [[ -f /etc/snapper/configs/root ]]; then
      sudo sed -i 's/^TIMELINE_CREATE="yes"/TIMELINE_CREATE="no"/' /etc/snapper/configs/root
      sudo sed -i 's/^NUMBER_LIMIT="50"/NUMBER_LIMIT="5"/' /etc/snapper/configs/root
      sudo sed -i 's/^NUMBER_LIMIT_IMPORTANT="10"/NUMBER_LIMIT_IMPORTANT="5"/' /etc/snapper/configs/root
      sudo sed -i 's/^SPACE_LIMIT="0.5"/SPACE_LIMIT="0.3"/' /etc/snapper/configs/root
      sudo sed -i 's/^FREE_LIMIT="0.2"/FREE_LIMIT="0.3"/' /etc/snapper/configs/root
    fi

    if [[ -f /etc/snapper/configs/home ]]; then
      sudo sed -i 's/^TIMELINE_CREATE="yes"/TIMELINE_CREATE="no"/' /etc/snapper/configs/home
      sudo sed -i 's/^NUMBER_LIMIT="50"/NUMBER_LIMIT="5"/' /etc/snapper/configs/home
      sudo sed -i 's/^NUMBER_LIMIT_IMPORTANT="10"/NUMBER_LIMIT_IMPORTANT="5"/' /etc/snapper/configs/home
      sudo sed -i 's/^SPACE_LIMIT="0.5"/SPACE_LIMIT="0.3"/' /etc/snapper/configs/home
      sudo sed -i 's/^FREE_LIMIT="0.2"/FREE_LIMIT="0.3"/' /etc/snapper/configs/home
    fi

    # Enable snapper sync service only if it exists
    if systemctl list-unit-files limine-snapper-sync.service &>/dev/null; then
      chrootable_systemctl_enable limine-snapper-sync.service
    else
      echo "Warning: limine-snapper-sync.service not found, skipping"
    fi
  else
    echo "Snapper or BTRFS not available, skipping snapshot configuration"
  fi

  echo "Re-enabling mkinitcpio hooks..."

  # Restore the specific mkinitcpio pacman hooks
  if [[ -f /usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled ]]; then
    sudo mv /usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled /usr/share/libalpm/hooks/90-mkinitcpio-install.hook
  fi

  if [[ -f /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled ]]; then
    sudo mv /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook
  fi

  echo "mkinitcpio hooks re-enabled"

  # Run limine-update only if the command exists
  if command -v limine-update &>/dev/null; then
    sudo limine-update

    # Verify that limine-update actually added boot entries
    if ! grep -q "^/+" /boot/limine.conf; then
      echo "Warning: limine-update did not add boot entries to /boot/limine.conf" >&2
    fi
  else
    echo "Warning: limine-update command not found, skipping boot entry generation"
  fi

  if [[ -n ${EFI:-} ]] && command -v efibootmgr &>/dev/null && efibootmgr &>/dev/null; then
    # Remove the archinstall-created Limine entry
    while IFS= read -r bootnum; do
      sudo efibootmgr -b "$bootnum" -B >/dev/null 2>&1
    done < <(efibootmgr | grep -E "^Boot[0-9]{4}\*? Arch Linux Limine" | sed 's/^Boot\([0-9]\{4\}\).*/\1/')
  fi
fi
