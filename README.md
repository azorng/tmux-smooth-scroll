# tmux-smooth-scroll

Smooth scrolling for tmux copy-mode. Detects your scrolling `mode-keys` and replaces them with animated versions. 

## Installation

### Using TPM

Add to `~/.tmux.conf`:

```tmux
set -g @plugin 'azorng/tmux-smooth-scroll'
```

Press `prefix + I` to install.

### Manual

Clone to tmux plugins directory:

```bash
git clone https://github.com/azorng/tmux-smooth-scroll ~/.tmux/plugins/tmux-smooth-scroll
```

Add to `~/.tmux.conf`:

```tmux
run-shell ~/.tmux/plugins/tmux-smooth-scroll/smooth-scroll.tmux
```

Reload: `tmux source-file ~/.tmux.conf`

## Configuration

Optional in `~/.tmux.conf`:

```tmux
# Speed: 0-1000 | lower = faster
set -g @smooth-scroll-speed "50"

# Scroll line distance
set -g @smooth-scroll-normal "3"
set -g @smooth-scroll-halfpage ""  # Default: pane_height / 2
set -g @smooth-scroll-fullpage ""  # Default: pane_height
```

