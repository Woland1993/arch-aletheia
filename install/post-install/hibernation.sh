# Enable hibernation if available
if command -v aletheia-hibernation-setup &>/dev/null; then
  aletheia-hibernation-setup --force || echo "Warning: Hibernation setup skipped (no swap or unsupported)" >&2
fi
