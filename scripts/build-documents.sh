#!/usr/bin/env bash
# Build the LuaLaTeX documents from the repository root.
#
# Usage:
#   scripts/build-documents.sh [overview|theory|all]
#   scripts/build-documents.sh watch [overview|theory]

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tex_cache_root="$repo_root/.latex-cache"

# Keep LuaLaTeX's font cache in the workspace.  This also works when the
# container's home directory is read-only or mounted with restrictive access.
mkdir -p "$tex_cache_root/texmf-var" "$tex_cache_root/texmf-config"
export TEXMFVAR="$tex_cache_root/texmf-var"
export TEXMFCONFIG="$tex_cache_root/texmf-config"

build_document() {
  local document_dir="$1"
  local source_file="$2"
  local mode="${3:-build}"
  local -a latexmk_args=(
    --shell-escape
    -synctex=1
    -interaction=nonstopmode
    -file-line-error
    -lualatex
    -outdir=out
  )

  if [[ "$mode" == "watch" ]]; then
    # In a terminal-only container, latexmk's default previewer is acroread.
    # Disable it: scripts/watch-document.sh provides the terminal preview.
    latexmk_args+=(-pvc -view=none)
  fi

  (
    cd "$repo_root/$document_dir"
    latexmk "${latexmk_args[@]}" "$source_file"
  )
}

target="${1:-all}"

case "$target" in
  overview)
    build_document doc/overview overview.tex
    ;;
  theory)
    build_document doc/theory book.tex
    ;;
  all)
    build_document doc/overview overview.tex
    build_document doc/theory book.tex
    ;;
  watch)
    watch_target="${2:-overview}"
    case "$watch_target" in
      overview) build_document doc/overview overview.tex watch ;;
      theory) build_document doc/theory book.tex watch ;;
      *)
        echo "Watch target must be 'overview' or 'theory'." >&2
        exit 2
        ;;
    esac
    ;;
  *)
    echo "Usage: $0 [overview|theory|all]" >&2
    echo "       $0 watch [overview|theory]" >&2
    exit 2
    ;;
esac
