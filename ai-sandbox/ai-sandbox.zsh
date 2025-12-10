# ai-sandbox functions
# Source this from .zshrc

SANDBOX_IMAGE="ai-sandbox"
SANDBOX_CONFIG="$HOME/dotfiles/ai-sandbox"
SANDBOX_DOCKERFILE="$SANDBOX_CONFIG/Dockerfile"

# Run command (or shell) in sandboxed container
#
# Config is stored in Docker named volumes, isolated from host.
# Set AI_SANDBOX_PROFILE env var to switch between accounts (e.g., "personal", "work").
# Defaults to "default". Use .envrc to set per-directory.
#
ai-sandbox() {
  local mount_dir
  if git rev-parse --show-toplevel &>/dev/null; then
    mount_dir=$(git rev-parse --show-toplevel)
  else
    mount_dir=$(pwd)
  fi

  # Compute workspace path: relative to $HOME if within it, otherwise absolute with _root prefix
  local workspace_subpath
  if [[ "$mount_dir" == "$HOME" ]]; then
    workspace_subpath=""
  elif [[ "$mount_dir" == "$HOME/"* ]]; then
    workspace_subpath="${mount_dir#$HOME/}"
  else
    workspace_subpath="_root$mount_dir"
  fi

  local workspace_path="/workspace${workspace_subpath:+/$workspace_subpath}"

  # Working directory within workspace
  local rel_path="${PWD#$mount_dir}"
  rel_path="${rel_path#/}"

  # Parse docker args (flags before the command)
  local docker_args=()
  while [[ $# -gt 0 && "$1" == -* ]]; do
    docker_args+=("$1")
    shift
    if [[ "${docker_args[-1]}" =~ ^-(p|v|e|w)$ ]]; then
      docker_args+=("$1")
      shift
    fi
  done

  # Profile-based named volume for config isolation
  local profile="${AI_SANDBOX_PROFILE:-default}"
  local config_volume="ai-sandbox-config-${profile}"

  docker run -it --rm \
    -v "$mount_dir":"$workspace_path" \
    -v "$HOME/dotfiles":/home/agent/dotfiles:ro \
    -v "$config_volume":/home/agent/sandbox-config \
    -e XDG_CONFIG_HOME=/home/agent/sandbox-config/config \
    -e XDG_DATA_HOME=/home/agent/sandbox-config/share \
    -e CLAUDE_CONFIG_DIR=/home/agent/sandbox-config/claude \
    -e CODEX_HOME=/home/agent/sandbox-config/codex \
    -w "$workspace_path${rel_path:+/$rel_path}" \
    -u "$(id -u):$(id -g)" \
    "${docker_args[@]}" \
    "$SANDBOX_IMAGE" \
    "$@"
}

# Rebuild ai-sandbox image, fetching latest AI tool versions
ai-sandbox-rebuild() {
  local claude_version codex_version

  echo "Fetching latest versions..."
  claude_version=$(npm view @anthropic-ai/claude-code version 2>/dev/null || echo "latest")
  codex_version=$(npm view @openai/codex version 2>/dev/null || echo "latest")
  amp_version=$(npm view @sourcegraph/amp version 2>/dev/null || echo "latest")

  echo "Building with claude-code@$claude_version, codex@$codex_version"
  
  docker build \
    --build-arg USER_UID="$(id -u)" \
    --build-arg USER_GID="$(id -g)" \
    --build-arg CLAUDE_CODE_VERSION="$claude_version" \
    --build-arg CODEX_VERSION="$codex_version" \
    --build-arg AMP_VERSION="$amp_version" \
    -t "$SANDBOX_IMAGE" \
    -f "$SANDBOX_DOCKERFILE" \
    "$SANDBOX_CONFIG"
}

# List existing sandbox profiles (based on Docker volumes)
ai-sandbox-profiles() {
  echo "Existing profiles:"
  docker volume ls --format '{{.Name}}' | grep '^ai-sandbox-config-' | sed 's/^ai-sandbox-config-/  /' | sort -u
  echo ""
  echo "Current: ${AI_SANDBOX_PROFILE:-default}"
}

# Convenience aliases
alias freeclaude="ai-sandbox claude --dangerously-skip-permissions"
alias freecodex="ai-sandbox codex --dangerously-bypass-approvals-and-sandbox"
alias freeamp="ai-sandbox amp --dangerously-allow-all"
