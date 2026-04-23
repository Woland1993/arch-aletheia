# Remove rustup if it's present on the system. Aletheia does NOT use rustup
# at all — we use the official `rust` package for any system-wide needs
# (e.g. tree-sitter-cli), and developers who want a Rust toolchain get it
# via `aletheia-install-dev-env rust`, which installs Rust through `mise`
# (not rustup).
#
# rustup and rust declare mutual conflict in their PKGBUILDs, so having
# rustup pre-installed would break pacman's non-interactive batch install.

if pacman -Q rustup &>/dev/null; then
  echo "rustup is installed on the system — removing to avoid conflict with rust"
  # -Rdd: skip dependency check (something harmless may declare rustup)
  sudo pacman -Rdd --noconfirm rustup || true
fi

# Also clean up any legacy user-level rustup install from the previous
# `curl sh.rustup.rs` flow. New dev installs go through `mise use rust`.
if command -v rustup &>/dev/null; then
  echo "Legacy rustup found in \$HOME — self-uninstalling"
  rustup self uninstall -y 2>/dev/null || true
fi
