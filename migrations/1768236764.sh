echo "Prevent kernel upgrades from making current modules unavailable"

aletheia-pkg-add kernel-modules-hook
sudo systemctl enable --now linux-modules-cleanup.service
