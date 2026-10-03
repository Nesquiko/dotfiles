#!/usr/bin/env bash
set -euo pipefail

usage() {
    printf 'Usage: %s [--dry-run]\n' "${0##*/}"
    printf 'Refresh the nvim, tmux, lazygit, yazi, and agents links in your home directory.\n'
}

stow_options=()
if (( $# > 1 )); then
    usage >&2
    exit 2
fi
case "${1:-}" in
    '') ;;
    --dry-run|-n) stow_options+=(--simulate) ;;
    --help|-h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
esac

if ! command -v stow >/dev/null 2>&1; then
    printf 'GNU Stow is required. On Arch, install it with: sudo pacman -S stow\n' >&2
    exit 1
fi

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
cd -- "$repo_dir"

# Restow also removes stale links. Conflicting real files are never adopted.
exec stow --restow --verbose --no-folding \
    --dir="$repo_dir" --target="${HOME:?HOME must be set}" \
    "${stow_options[@]}" nvim tmux lazygit yazi agents
