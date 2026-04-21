echo "Change to aletheia-nvim package"
aletheia-pkg-drop aletheia-lazyvim
aletheia-pkg-add aletheia-nvim

# Will trigger to overwrite configs or not to pickup new hot-reload themes
aletheia-nvim-setup
