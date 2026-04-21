echo "Fix microphone gain and audio mixing on Asus ROG laptops"

source "$ALETHEIA_PATH/install/config/hardware/asus/fix-mic.sh"
source "$ALETHEIA_PATH/install/config/hardware/asus/fix-audio-mixer.sh"

if aletheia-hw-asus-rog; then
  aletheia-restart-pipewire
fi
