#!/usr/bin/env bash
# Tmux smooth-scroll plugin initialization

PLUGIN_DIR="$( cd "$( dirname "$0" )/.." && pwd )"
SCROLL_SCRIPT="$PLUGIN_DIR/src/scroll.sh"

MODE_KEYS="$(tmux show-option -gwq mode-keys)"
TABLE="copy-mode-vi"
[ "$MODE_KEYS" = "emacs" ] && TABLE="copy-mode"

# Map tmux scroll commands to scroll types
declare -A SCROLL_MAP=(
    ["scroll-up"]="up normal"
    ["scroll-down"]="down normal"
    ["halfpage-up"]="up halfpage"
    ["halfpage-down"]="down halfpage"
    ["page-up"]="up fullpage"
    ["page-down"]="down fullpage"
)

# Capture existing bindings
mapfile -t bindings < <(tmux list-keys -T "$TABLE")

# Find keys bound to scroll commands and rebind
for line in "${bindings[@]}"; do
    for cmd in "${!SCROLL_MAP[@]}"; do
        if [[ "$line" =~ send-keys.*[[:space:]]$cmd$ ]]; then
            key=$(echo "$line" | awk '{print $4}')
            [ -n "$key" ] && tmux bind-key -T "$TABLE" "$key" run-shell -b "$SCROLL_SCRIPT ${SCROLL_MAP[$cmd]}"
        fi
    done
done
