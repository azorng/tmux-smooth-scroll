#!/usr/bin/env bash
# Tmux smooth-scroll plugin initialization
source "$(dirname "$0")/config.sh"

MODE_KEYS="$(tmux show-option -gwq mode-keys)"
TABLE="copy-mode-vi"
[ "$MODE_KEYS" = "emacs" ] && TABLE="copy-mode"

# Find keys bound to scroll commands and rebind
tmux list-keys -T "$TABLE" | while IFS= read -r line; do
    # Skip mouse wheel events if explicitly disabled
    if [ "$(config__mouse_scroll)" = "false" ]; then
        case "$line" in
            *Wheel*) continue ;;
        esac
    fi
    
    case "$line" in
        *send-keys*scroll-up|*scroll.sh*up*normal*)         params="up normal" ;;
        *send-keys*scroll-down|*scroll.sh*down*normal*)     params="down normal" ;;
        *send-keys*halfpage-up|*scroll.sh*up*halfpage*)     params="up halfpage" ;;
        *send-keys*halfpage-down|*scroll.sh*down*halfpage*) params="down halfpage" ;;
        *send-keys*page-up|*scroll.sh*up*fullpage*)         params="up fullpage" ;;
        *send-keys*page-down|*scroll.sh*down*fullpage*)     params="down fullpage" ;;
        *) continue ;;
    esac
    
    key=$(echo "$line" | awk '{print $4}')
    [ -z "$key" ] && continue

    case "$key" in
        Wheel*Pane)
            # Wheel bindings need the mouse pane passed into scroll.sh.
            tmux bind-key -T "$TABLE" "$key" run-shell -b -t = "TMUX_PANE=#{pane_id} $SRC_DIR/scroll.sh $params"
            ;;
        *)
            tmux bind-key -T "$TABLE" "$key" run-shell -b "$SRC_DIR/scroll.sh $params"
            ;;
    esac
done
