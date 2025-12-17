#!/usr/bin/env bash
# Centralized settings

SRC_DIR="$(dirname "$0")"

# Speed: 0-1000 scale (lower = faster)
config__speed() {
    local speed="$(tmux show-option -gqv "@smooth-scroll-speed")"
    echo "${speed:-50}"
}

# Scroll distances
config__normal_lines() {
    local lines="$(tmux show-option -gqv "@smooth-scroll-normal")"
    echo "${lines:-3}"
}

config__halfpage_lines() {
    local lines="$(tmux show-option -gqv "@smooth-scroll-halfpage")"
    local pane_height="${1:-$(tmux display-message -p '#{pane_height}')}"
    echo "${lines:-$((pane_height / 2))}"
}

config__fullpage_lines() {
    local lines="$(tmux show-option -gqv "@smooth-scroll-fullpage")"
    local pane_height="${1:-$(tmux display-message -p '#{pane_height}')}"
    echo "${lines:-$pane_height}"
}

# Mouse wheel scrolling enabled (default: true)
config__mouse_scroll() {
    local mouse="$(tmux show-option -gqv "@smooth-scroll-mouse")"
    echo "${mouse:-true}"
}
