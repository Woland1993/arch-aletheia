echo "Change to openai-codex instead of openai-codex-bin"

if aletheia-pkg-present openai-codex-bin; then
    aletheia-pkg-drop openai-codex-bin
    aletheia-pkg-add openai-codex
fi
