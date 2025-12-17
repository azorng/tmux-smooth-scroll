#!/usr/bin/env bash
# Plugin integration layer
# Handles tmux configuration, scroll distance calculation, and calls animator

source "$(dirname "$0")/config.sh"

DIRECTION=$1
SCROLL_TYPE=$2

# Calculate scroll distance based on pane height
PANE_HEIGHT=$(tmux display-message -p '#{pane_height}')

case "$SCROLL_TYPE" in
    halfpage)
        LINES="$(config__halfpage_lines "$PANE_HEIGHT")"
        ;;
    fullpage)
        LINES="$(config__fullpage_lines "$PANE_HEIGHT")"
        ;;
    normal)
        LINES="$(config__normal_lines)"
        ;;
    small)
        LINES=1
        ;;
    *)
        LINES="$SCROLL_TYPE"
        ;;
esac

# Base delay per line: 0-100 maps to 1000µs - 10000µs linearly
BASE_DELAY=$((1000 + $(config__speed) * 90))

# For small scrolls (≤ 5 lines), multiply delay to keep animation visible
if [ "$LINES" -le 5 ] && [ "$LINES" -gt 0 ]; then
    BASE_DELAY=$((BASE_DELAY * 5))
fi

# Delegate to pure animator
exec "$SRC_DIR/animate.sh" "$DIRECTION" "$LINES" "$BASE_DELAY"
