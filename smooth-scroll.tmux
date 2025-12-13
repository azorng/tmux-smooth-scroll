#!/usr/bin/env bash
# Tmux smooth-scroll plugin entry point

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

exec "$CURRENT_DIR/src/init.sh"
