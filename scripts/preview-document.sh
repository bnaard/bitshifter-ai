#!/usr/bin/env bash
# Render one PDF page inline and refresh it after each rebuild.
# Intended for WezTerm inside tmux; it requires pdftoppm and chafa.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="${1:-overview}"
page="${2:-1}"
# WezTerm supports the iTerm2 inline-image protocol.  Chafa wraps it in the
# tmux passthrough sequence, and tmux is configured with allow-passthrough on.
# Set PREVIEW_PROTOCOL=symbols for the portable text-only fallback.
preview_protocol="${PREVIEW_PROTOCOL:-iterm}"

case "$target" in
  overview) pdf="$repo_root/doc/overview/out/overview.pdf" ;;
  theory) pdf="$repo_root/doc/theory/out/book.pdf" ;;
  *)
    echo "Target must be 'overview' or 'theory'." >&2
    exit 2
    ;;
esac

for tool in pdftoppm base64; do
  command -v "$tool" >/dev/null 2>&1 || {
    echo "Required command not found: $tool" >&2
    exit 1
  }
done

work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT
last_stamp=""
last_size=""
last_render=0
zoom=100

page_count() {
  pdfinfo "$pdf" | awk '/^Pages:/ { print $2; exit }'
}

render() {
  local width height image_width image_height
  width="${COLUMNS:-$(tput cols 2>/dev/null || echo 80)}"
  height="${LINES:-$(tput lines 2>/dev/null || echo 24)}"
  height=$((height > 5 ? height - 5 : 20))
  image_width=$((width * zoom / 100))
  image_height=$((height * zoom / 100))

  pdftoppm -f "$page" -l "$page" -singlefile -png \
    -scale-to-x 1600 -scale-to-y -1 "$pdf" "$work_dir/page"
  printf '\033[2J\033[H'
  printf 'PDF preview: %s, page %s/%s, zoom %s%%\n' \
    "$target" "$page" "$(page_count)" "$zoom"
  printf 'Controls: n/right next, p/left previous, +/- zoom, q quit\n'
  case "$preview_protocol" in
    iterm)
      # OSC 1337 needs tmux's DCS wrapper to reach the WezTerm client.
      # Chafa 1.14 does not wrap its iTerm output reliably, so emit the
      # small, documented protocol sequence directly.
      printf '\033Ptmux;\033\033]1337;File=inline=1;width=%s;height=%s;preserveAspectRatio=1:' \
        "$image_width" "$image_height"
      base64 -w 0 "$work_dir/page.png"
      printf '\a\033\\'
      ;;
    symbols)
      command -v chafa >/dev/null 2>&1 || {
        echo "Required command not found: chafa" >&2
        exit 1
      }
      chafa --format=symbols --colors=full --size="${width}x${height}" \
        "$work_dir/page.png"
      ;;
    *)
      echo "PREVIEW_PROTOCOL must be 'iterm' or 'symbols'." >&2
      exit 2
      ;;
  esac
}

while true; do
  if [[ -f "$pdf" ]]; then
    stamp="$(stat -c '%Y:%s' "$pdf")"
    size="${COLUMNS:-$(tput cols 2>/dev/null || echo 80)}:${LINES:-$(tput lines 2>/dev/null || echo 24)}"
    now="$(date +%s)"
    # tmux does not retain inline images in its screen buffer. Refreshing at
    # least every three seconds restores the preview after a window switch.
    if [[ "$stamp" != "$last_stamp" || "$size" != "$last_size" || \
      $((now - last_render)) -ge 3 ]]; then
      render
      last_stamp="$stamp"
      last_size="$size"
      last_render="$now"
    fi
  else
    printf '\033[2J\033[HWaiting for %s to be built...\n' "$pdf"
  fi

  if IFS= read -rsn1 -t 0.2 key; then
    max_page="$(page_count)"
    case "$key" in
      n|l) if ((page < max_page)); then ((page += 1)); fi ;;
      p|h) if ((page > 1)); then ((page -= 1)); fi ;;
      +|=) if ((zoom < 200)); then ((zoom += 25)); fi ;;
      -|_) if ((zoom > 50)); then ((zoom -= 25)); fi ;;
      q) exit 0 ;;
      $'\e')
        # Consume the final byte of an arrow-key sequence when present.
        IFS= read -rsn2 -t 0.05 key || true
        case "$key" in
          '[C') if ((page < max_page)); then ((page += 1)); fi ;;
          '[D') if ((page > 1)); then ((page -= 1)); fi ;;
        esac
        ;;
    esac
    last_render=0
  fi
done
