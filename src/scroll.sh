#!/usr/bin/env bash
# Plugin integration layer
# Handles tmux configuration, scroll distance calculation, and calls animator

DIRECTION=$1
SCROLL_TYPE=$2

# Read speed setting (lower = faster, 0-100 scale)
SPEED="$(tmux show-option -gqv "@smooth-scroll-speed")"
SPEED="${SPEED:-50}"

# Calculate scroll distance based on pane height
PANE_HEIGHT=$(tmux display-message -p '#{pane_height}')

# Read custom scroll distances
HALFPAGE_LINES="$(tmux show-option -gqv "@smooth-scroll-halfpage")"
FULLPAGE_LINES="$(tmux show-option -gqv "@smooth-scroll-fullpage")"
NORMAL_LINES="$(tmux show-option -gqv "@smooth-scroll-normal")"

case "$SCROLL_TYPE" in
    halfpage)
        LINES="${HALFPAGE_LINES:-$((PANE_HEIGHT / 2))}"
        ;;
    fullpage)
        LINES="${FULLPAGE_LINES:-$PANE_HEIGHT}"
        ;;
    normal)
        LINES="${NORMAL_LINES:-3}"
        ;;
    small)
        LINES=1
        ;;
    *)
        LINES="$SCROLL_TYPE"
        ;;
esac

# Base delay per line: 0-100 maps to 1000µs - 10000µs linearly
BASE_DELAY=$((1000 + SPEED * 90))

# For small scrolls (≤ 5 lines), multiply delay to keep animation visible
if [ "$LINES" -le 5 ] && [ "$LINES" -gt 0 ]; then
    BASE_DELAY=$((BASE_DELAY * 5))
fi

# Delegate to pure animator
SCRIPT_DIR="$(dirname "$0")"
exec "$SCRIPT_DIR/animate.sh" "$DIRECTION" "$LINES" "$BASE_DELAY"
