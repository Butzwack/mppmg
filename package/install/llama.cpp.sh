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

echo "Checking HIP/ROCm build dependencies..."
for dep in libamdhip64-dev libhipblas-dev librocblas-dev hipcc librocwmma-dev; do
    if ! dpkg -s "$dep" &>/dev/null; then
        echo "Missing $dep, installing..."
        sudo apt install -y "$dep"
    fi
done

# librocwmma-dev from Ubuntu is missing internal/ headers — pull from source
if [ ! -d "/usr/include/rocwmma/internal" ]; then
    echo "Installing rocWMMA internal headers from source..."
    ROCWMMA_TAG="rocm-7.1.0"
    if [ -d "/tmp/rocWMMA/.git" ]; then
        cd /tmp/rocWMMA && git fetch --all && git checkout "$ROCWMMA_TAG"
    else
        git clone --depth 1 --branch "$ROCWMMA_TAG" https://github.com/ROCm/rocWMMA /tmp/rocWMMA
    fi
    sudo cp -r /tmp/rocWMMA/library/include/rocwmma/internal /usr/include/rocwmma/
    cd "$CLONE_DIR"
fi

mkdir -p "$BIN_DIR"

if [ -d "$CLONE_DIR/.git" ]; then
    echo "Repository already cloned at $CLONE_DIR"
else
    echo "Cloning llama.cpp..."
    git clone "$REPO" "$CLONE_DIR"
fi

cd "$CLONE_DIR"

echo "Configuring build with Vulkan + HIP backends..."
HSA_OVERRIDE_GFX_VERSION=12.0.0 \
HIPCXX="$(hipconfig -l)/clang" \
HIP_PATH="$(hipconfig -R)" \
HIP_DEVICE_LIB_PATH="$(dirname "$(find /usr -name oclc_abi_version_400.bc 2>/dev/null)")" \
cmake -B build -DCMAKE_BUILD_TYPE=Release -DGGML_VULKAN=1 -DGGML_HIP=ON -DGGML_HIP_ROCWMMA_FATTN=ON

echo "Building (this may take a while)..."
cmake --build build --config Release -j

echo "Installing llama-server to $BIN_DIR..."
cp -f build/bin/llama-server build/bin/llama-bench "$BIN_DIR/"

echo "Done."
