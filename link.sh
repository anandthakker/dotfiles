#!/usr/bin/env bash
set -euo pipefail

# Clone dotfiles into ~/dotfiles, then run this.

cd "$HOME" || exit 1

# Link dotfiles in $HOME (skip . and .. and .git)
for path in "$HOME"/dotfiles/.*; do
  base="${path##*/}"
  case "$base" in
    .|..|.git) continue ;;
  esac

  target="$HOME/$base"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "$base exists: skipping."
  else
    ln -s "$path" "$target"
    echo "Linked $base."
  fi
done

mkdir -p "$HOME/.config"
cd "$HOME/.config" || exit 1

for dir in ghostty direnv; do
  if [ -d "$dir" ] || [ -L "$dir" ]; then
    echo ".config/$dir exists: skipping."
  else
    ln -s "$HOME/dotfiles/$dir" "$dir"
    echo "Linked .config/$dir"
  fi
done
