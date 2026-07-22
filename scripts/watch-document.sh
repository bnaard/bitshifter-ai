#!/usr/bin/env bash
# Open a tmux window with a LuaLaTeX watcher and a live terminal PDF preview.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="${1:-overview}"

case "$target" in
  overview|theory) ;;
  *)
    echo "Usage: $0 [overview|theory]" >&2
    exit 2
    ;;
esac

if [[ -z "${TMUX:-}" ]]; then
  echo "Run this from inside tmux." >&2
  exit 1
fi

printf -v watch_command 'exec %q watch %q' \
  "$repo_root/scripts/build-documents.sh" "$target"
printf -v preview_command 'exec %q %q' \
  "$repo_root/scripts/preview-document.sh" "$target"

watch_pane="$(tmux new-window -d -P -F '#{pane_id}' -n "latex-$target" \
  -c "$repo_root" "$watch_command")"
preview_pane="$(tmux split-window -d -h -P -F '#{pane_id}' -t "$watch_pane" \
  -c "$repo_root" "$preview_command")"
tmux select-layout -t "$watch_pane" even-horizontal
tmux select-window -t "$watch_pane"
tmux select-pane -t "$preview_pane"
