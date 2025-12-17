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

# Delegate to pure animator
exec "$SRC_DIR/animate.sh" "$DIRECTION" "$LINES" "$BASE_DELAY" "$(config__easing_mode)"
