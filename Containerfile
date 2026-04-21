FROM node:24-bookworm-slim

# 1. Install system tools + Python + Git + Compilers
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    curl \
    git \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 2. Setup PATHs
# Including paths for: NPM globals, Rust/Cargo, and UV-installed tools
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:/home/node/.cargo/bin:/home/node/.local/bin:${PATH}"

# 3. Prepare Folders & Permissions
RUN mkdir -p /home/node/.npm-global /home/node/.pi /home/node/.pi-lens /home/node/.cargo /usr/src/app \
    && chown -R node:node /home/node /usr/src/app

USER node
WORKDIR /usr/src/app

# 4. Install Rust via rustup (non-interactive)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

# 5. Install UV (Python Manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# 6. Pre-install tools and agent
# - npm for JS tools
# - uv for ruff (handles the PEP 668 environment lock perfectly)
RUN npm install -g @ast-grep/cli madge jscpd knip @mariozechner/pi-coding-agent \
    && /home/node/.local/bin/uv tool install ruff \
    && npm cache clean --force

ENV HOME=/home/node
ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["pi"]
