#!/bin/bash

set -euo pipefail

REPO="https://github.com/ggml-org/llama.cpp"
CLONE_DIR="$HOME/git/llama.cpp"
BIN_DIR="$HOME/bin"

echo "Checking Vulkan build dependencies..."
for dep in libvulkan-dev glslc spirv-headers; do
    if ! dpkg -s "$dep" &>/dev/null; then
        echo "Missing $dep, installing..."
        sudo apt install -y "$dep"
    fi
done

mkdir -p "$BIN_DIR"

if [ -d "$CLONE_DIR/.git" ]; then
    echo "Repository already cloned at $CLONE_DIR"
else
    echo "Cloning llama.cpp..."
    git clone "$REPO" "$CLONE_DIR"
fi

cd "$CLONE_DIR"

echo "Configuring build with Vulkan backend..."
cmake -B build -DCMAKE_BUILD_TYPE=Release -DGGML_VULKAN=1

echo "Building (this may take a while)..."
cmake --build build --config Release -j

echo "Installing llama-server to $BIN_DIR..."
cp -f build/bin/llama-server build/bin/llama-bench "$BIN_DIR/"

echo "Done."
