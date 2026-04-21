#!/bin/bash

# Configuration
IMAGE_NAME="pi-agent"

# --pull-always: Ensures you get the latest security patches for the base Alpine image
# --layers: Uses caching to speed up subsequent builds
# --format docker: Ensures compatibility if you ever decide to move back to Docker
podman build \
    --pull-always \
    --format docker \
    -t "$IMAGE_NAME" \
    -f Containerfile
