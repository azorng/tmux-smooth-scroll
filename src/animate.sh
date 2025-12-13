#!/usr/bin/env bash
# Pure animation executor
# Input: direction (up|down), lines (int), base_delay_us (int microseconds)
# Output: executes smooth scroll animation

DIRECTION=$1
LINES=$2
BASE_DELAY_US=$3

# Validate inputs
[[ ! "$DIRECTION" =~ ^(up|down)$ ]] && exit 1
[[ ! "$LINES" =~ ^[0-9]+$ ]] || [ "$LINES" -lt 1 ] && exit 1

perl -MTime::HiRes=usleep -e '
    my $delay = $ARGV[0];
    for (my $i = 0; $i < $ARGV[1]; $i++) {
        system("tmux", "send-keys", "-X", "scroll-" . $ARGV[2]);
        usleep($delay) if $i < $ARGV[1] - 1;
    }
' "$BASE_DELAY_US" "$LINES" "$DIRECTION"
