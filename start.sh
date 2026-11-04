#!/usr/bin/env bash
# ============================================================
#  Signal Lab launcher (Linux)
#  Run:   bash start.sh
#  (On a USB flash drive, "bash start.sh" is needed because the
#   drive is usually mounted without permission to run scripts.)
#  It opens index.html in the computer's DEFAULT browser (whatever
#  it is). Keep this file in the same folder as index.html.
#  For full screen press F11, or use the "Fullscreen" button inside
#  the page (works in every browser).
#
#  Settings:
#   MODE=default     open with the default browser (recommended)
#   MODE=fullscreen  look for Chrome-family / Firefox and start it
#                    already full screen
#   FIREFOX_KIOSK=1  (fullscreen mode) Firefox without window
#                    controls; to leave it press Alt+F4
# ============================================================
MODE=default
FIREFOX_KIOSK=0

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PAGE="$DIR/index.html"
if [ ! -f "$PAGE" ]; then
  echo "index.html was not found next to this file: $PAGE"
  echo "Copy start.sh and index.html into the same folder."
  exit 1
fi
URL="file://$(printf '%s' "$PAGE" | sed 's/ /%20/g')"

# 0) Default browser
if [ "$MODE" = "default" ] && command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$PAGE" >/dev/null 2>&1 &
  echo "Opened in the default browser."
  echo "For full screen press F11 or use the Fullscreen button in the page."
  exit 0
fi

# 1) Chromium-family browsers: real full screen from the command line
for b in google-chrome google-chrome-stable chromium chromium-browser microsoft-edge microsoft-edge-stable brave-browser; do
  if command -v "$b" >/dev/null 2>&1; then
    "$b" --start-fullscreen --new-window "$URL" >/dev/null 2>&1 &
    exit 0
  fi
done

# 2) Firefox
if command -v firefox >/dev/null 2>&1; then
  if [ "$FIREFOX_KIOSK" = "1" ]; then
    firefox --kiosk "$URL" >/dev/null 2>&1 &
  else
    firefox --new-window "$URL" >/dev/null 2>&1 &
    echo "Opened in Firefox. Press F11 for full screen."
  fi
  exit 0
fi

# 3) Anything else: the default browser
if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$PAGE" >/dev/null 2>&1 &
  echo "Opened in the default browser. Press F11 for full screen."
  exit 0
fi

echo "No browser was found. Open this file manually: $PAGE"
exit 1
