#!/usr/bin/env bash
# Tmux smooth-scroll plugin initialization

PLUGIN_DIR="$( cd "$( dirname "$0" )/.." && pwd )"
SCROLL_SCRIPT="$PLUGIN_DIR/src/scroll.sh"

MODE_KEYS="$(tmux show-option -gwq mode-keys)"
TABLE="copy-mode-vi"
[ "$MODE_KEYS" = "emacs" ] && TABLE="copy-mode"

# Find keys bound to scroll commands and rebind
tmux list-keys -T "$TABLE" | while IFS= read -r line; do
    case "$line" in
        *send-keys*scroll-up)       params="up normal" ;;
        *send-keys*scroll-down)     params="down normal" ;;
        *send-keys*halfpage-up)     params="up halfpage" ;;
        *send-keys*halfpage-down)   params="down halfpage" ;;
        *send-keys*page-up)         params="up fullpage" ;;
        *send-keys*page-down)       params="down fullpage" ;;
        *) continue ;;
    esac
    
    key=$(echo "$line" | awk '{print $4}')
    [ -n "$key" ] && tmux bind-key -T "$TABLE" "$key" run-shell -b "$SCROLL_SCRIPT $params"
done
