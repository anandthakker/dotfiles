#!/usr/bin/env bash
set -euo pipefail

# Clone dotfiles into ~/dotfiles, then run this.

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Link dotfiles from ~/dotfiles to ~

Options:
  -n, --dry-run   Show what would be done without making changes
  -f, --force     Backup existing files and replace them
  -h, --help      Show this help message
EOF
}

DRY_RUN=false
FORCE=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run)
      DRY_RUN=true
      shift
      ;;
    -f|--force)
      FORCE=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

backup_and_link() {
  local source="$1"
  local target="$2"
  local name="$3"

  # Already correctly linked - nothing to do
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    echo "$name: already linked."
    return
  fi

  # Something exists at target
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ "$FORCE" = true ]; then
      local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
      if [ "$DRY_RUN" = true ]; then
        echo "$name: would backup to ${backup##*/} and link."
      else
        mv "$target" "$backup"
        ln -s "$source" "$target"
        echo "$name: backed up to ${backup##*/} and linked."
      fi
    else
      echo "$name: exists (use --force to replace)."
    fi
    return
  fi

  # Nothing exists - create link
  if [ "$DRY_RUN" = true ]; then
    echo "$name: would link."
  else
    ln -s "$source" "$target"
    echo "$name: linked."
  fi
}

cd "$HOME" || exit 1

# Link dotfiles in $HOME (skip . and .. and .git)
for path in "$HOME"/dotfiles/.*; do
  base="${path##*/}"
  case "$base" in
    .|..|.git) continue ;;
  esac

  backup_and_link "$path" "$HOME/$base" "$base"
done

mkdir -p "$HOME/.config"

for dir in ghostty direnv; do
  source_dir="$HOME/dotfiles/$dir"
  target_dir="$HOME/.config/$dir"

  if [ -d "$source_dir" ]; then
    backup_and_link "$source_dir" "$target_dir" ".config/$dir"
  fi
done
