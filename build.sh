#!/bin/bash

# Configuration
IMAGE_NAME="pi-agent"

# --pull-always: Ensures you get the latest security patches for the base image
# --layers: Uses caching to speed up subsequent builds
podman build \
    --pull-always \
    -t "$IMAGE_NAME" \
    -f Containerfile
