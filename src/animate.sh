#!/usr/bin/env bash
# Pure animation executor
# Input: direction (up|down), lines (int), base_delay_us (int microseconds), easing_mode (linear|sine|expo)
# Output: executes smooth scroll animation

DIRECTION=$1
LINES=$2
BASE_DELAY_US=$3
EASING_MODE=${4}

# Validate inputs
[[ ! "$DIRECTION" =~ ^(up|down)$ ]] && exit 1
[[ ! "$LINES" =~ ^[0-9]+$ ]] || [ "$LINES" -lt 1 ] && exit 1
[[ ! "$BASE_DELAY_US" =~ ^[0-9]+$ ]] || [ "$BASE_DELAY_US" -lt 1 ] && exit 1
[[ ! "$EASING_MODE" =~ ^(linear|sine|quad)$ ]] && exit 1

# Execute animation with easing
SRC_DIR="$(dirname "$0")"
exec perl "$SRC_DIR/animator.pl" "$BASE_DELAY_US" "$LINES" "$DIRECTION" "$EASING_MODE"
