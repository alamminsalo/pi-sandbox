#!/bin/bash

IMAGE_NAME="pi-agent"
PI_DIR_LOCAL="$HOME/.pi"

# Cache dirs
mkdir -p "$PI_DIR_LOCAL" "$HOME/.uv_cache" "$HOME/.cargo_cache"

echo "🚀 Launching Pi Coding Agent..."

podman run -it --rm \
    --name pi-coding-agent \
    --network host \
    --userns=keep-id \
    -v "$PI_DIR_LOCAL:/home/node/.pi:Z" \
    -v "$HOME/.uv_cache:/home/node/.cache/uv:Z" \
    -v "$HOME/.cargo_cache:/home/node/.cargo:Z" \
    -v "$(pwd):/usr/src/app:Z" \
    -w /usr/src/app \
    "$IMAGE_NAME" "$@"
