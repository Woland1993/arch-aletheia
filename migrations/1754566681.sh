echo "Make new Osaka Jade theme available as new default"

if [[ ! -L ~/.config/aletheia/themes/osaka-jade ]]; then
  rm -rf ~/.config/aletheia/themes/osaka-jade
  git -C ~/.local/share/aletheia checkout -f themes/osaka-jade
  ln -nfs ~/.local/share/aletheia/themes/osaka-jade ~/.config/aletheia/themes/osaka-jade
fi
