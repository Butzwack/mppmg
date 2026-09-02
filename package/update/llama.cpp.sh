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
# Detect this machine's GPU architectures.
# HSA_OVERRIDE_GFX_VERSION must be cleared first: the enumerator honours it, so
# leaving it set bakes the overridden arch into the build (this is how a
# gfx1200-only binary ended up installed on a gfx1100 host).
#
# Detected arches are preferentially narrowed to those rocBLAS ships kernels
# for, which drops dead weight like ubuntu-pc's gfx1036 iGPU. That narrowing is
# best-effort only: strixpoint is gfx1150, which rocBLAS 7.1 does not list, so
# an empty intersection falls back to the raw detected set rather than failing.
detect_gpu_targets() {
    local detected supported narrowed
    detected=$(env -u HSA_OVERRIDE_GFX_VERSION rocm_agent_enumerator 2>/dev/null \
        | grep -E '^gfx[0-9a-z]+$' | grep -v '^gfx000$' | sort -u)
    [ -z "$detected" ] && return 0
    supported=$(ls /usr/lib/x86_64-linux-gnu/rocblas/*/library/ 2>/dev/null \
        | grep -oE 'gfx[0-9a-z]+' | sort -u)
    narrowed=$(comm -12 <(echo "$detected") <(echo "$supported"))
    [ -n "$narrowed" ] && detected="$narrowed"
    echo "$detected" | paste -sd';'
}

GPU_TARGETS="${AMDGPU_TARGETS:-$(detect_gpu_targets)}"
if [ -z "$GPU_TARGETS" ]; then
    echo "Error: no rocBLAS-supported GPU architecture detected." >&2
    echo "Set AMDGPU_TARGETS manually, e.g. AMDGPU_TARGETS=gfx1100" >&2
    exit 1
fi
echo "Building HIP kernels for: $GPU_TARGETS"

# CMAKE_HIP_ARCHITECTURES is set directly, not via AMDGPU_TARGETS: ggml only
# forwards AMDGPU_TARGETS when CMAKE_HIP_ARCHITECTURES is unset, so on an
# existing build dir the cached value would silently win and the rebuild would
# keep targeting the wrong arch.
HIPCXX="$(hipconfig -l)/clang" \
HIP_PATH="$(hipconfig -R)" \
HIP_DEVICE_LIB_PATH="$(dirname "$(find /usr -name oclc_abi_version_400.bc 2>/dev/null)")" \
cmake -B build -DCMAKE_BUILD_TYPE=Release -DGGML_VULKAN=1 -DGGML_HIP=ON \
      -DGGML_HIP_ROCWMMA_FATTN=ON -DCMAKE_HIP_ARCHITECTURES="$GPU_TARGETS"

echo "Rebuilding..."
cmake --build build --config Release -j

echo "Updating llama-server in $BIN_DIR..."
cp -f build/bin/llama-server build/bin/llama-bench "$BIN_DIR/"

echo "Done."
