FROM node:24-bookworm-slim

# System dependencies - very stable layer
RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  ca-certificates \
  curl \
  unzip \
  python3 \
  python3-pip \
  python3-venv \
  jq \
  ripgrep \
  fzf \
  less \
  vim \
  make \
  build-essential \
  wget \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Playwright
ARG PLAYWRIGHT_CORE_VERSION=latest
ENV PLAYWRIGHT_BROWSERS_PATH=/playwright
COPY ./pw-smoke-test.cjs /tmp/pw-smoke-test.cjs
RUN set -eux; \
  mkdir -p /opt/pw-install; \
  cd /opt/pw-install; \
  npm init -y; \
  npm i playwright-core@${PLAYWRIGHT_CORE_VERSION}; \
  npm exec --no -- playwright-core install --with-deps; \
  NODE_PATH=/opt/pw-install/node_modules node /tmp/pw-smoke-test.cjs; \
  rm /tmp/pw-smoke-test.cjs; \
  rm -rf /opt/pw-install /root/.npm /root/.cache /var/lib/apt/lists/*; \
  chmod -R 0777 /playwright;

# Set up user
ARG USER_UID
ARG USER_GID
RUN groupadd --gid ${USER_GID} agent 2>/dev/null || true \
  && useradd --uid ${USER_UID} --gid ${USER_GID} -m agent
USER agent

# Shell
ENV SHELL=/bin/bash
ENV EDITOR=vim
ENV VISUAL=vim
ENV TERM=xterm-256color
ENV COLORTERM=truecolor
ENV PROMPT_COMMAND="history -a"

# Bun
RUN curl -fsSL https://bun.sh/install | bash

# Explicitly add bun to path for use in build steps below
ENV PATH="/home/agent/.bun/bin:$PATH"

# Versioned tools
ARG CODEX_VERSION
RUN bun install -g @openai/codex@${CODEX_VERSION}

ARG CLAUDE_CODE_VERSION
RUN curl -fsSL https://claude.ai/install.sh | bash -s -x ${CLAUDE_CODE_VERSION}

ARG AMP_VERSION
RUN echo "Installing amp @ ${AMP_VERSION}" && \
  curl -fsSL https://ampcode.com/install.sh | bash

# Add claude to PATH (installed to ~/.local/bin)
ENV PATH="/home/agent/.local/bin:$PATH"

# Create config mount point owned by agent (for mounting a volume to)
RUN mkdir -p /home/agent/sandbox-config

# Default git config for AI agents
RUN git config --global user.name "AI Sandbox" \
  && git config --global user.email "ai-sandbox@localhost"

WORKDIR /workspace
CMD ["/bin/bash"]
