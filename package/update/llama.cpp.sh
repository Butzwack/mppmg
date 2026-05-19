#!/bin/bash

set -euo pipefail

CLONE_DIR="$HOME/git/llama.cpp"
BIN_DIR="$HOME/bin"

if [ ! -d "$CLONE_DIR/.git" ]; then
    echo "Error: llama.cpp not found at $CLONE_DIR. Run the install script first."
    exit 1
fi

cd "$CLONE_DIR"

echo "Pulling latest changes..."
git pull

echo "Reconfiguring build..."
cmake -B build -DCMAKE_BUILD_TYPE=Release -DGGML_VULKAN=1

echo "Rebuilding..."
cmake --build build --config Release -j

echo "Updating llama-server in $BIN_DIR..."
cp -f build/bin/llama-server build/bin/llama-bench "$BIN_DIR/"

echo "Done."
