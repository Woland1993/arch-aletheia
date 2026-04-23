echo "Change aletheia-screenrecord to use gpu-screen-recorder"
aletheia-pkg-drop wf-recorder wl-screenrec

# Add slurp in case it hadn't been picked up from an old migration
aletheia-pkg-add slurp gpu-screen-recorder
