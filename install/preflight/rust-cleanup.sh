# Remove rustup if it's present on the system. Aletheia uses the official
# `rust` package for any system-wide needs (e.g. tree-sitter-cli), and
# developers who want rustup install it later via `aletheia-install-dev-env`
# (which runs the upstream https://sh.rustup.rs script into $HOME).
#
# rustup and rust declare mutual conflict in their PKGBUILDs, so having
# rustup pre-installed would break pacman's non-interactive batch install.

if pacman -Q rustup &>/dev/null; then
  echo "rustup is installed on the system — removing to avoid conflict with rust"
  # -Rdd: skip dependency check (something harmless may declare rustup)
  # We re-install the actual `rust` package right after, so compiler is still available.
  sudo pacman -Rdd --noconfirm rustup || true
fi
