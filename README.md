<p align="center">
  <img src="https://github.com/user-attachments/assets/d4f90bb9-0626-4dec-8274-e48f8cc91914" alt="tmux-smooth-scroll logo" />
</p>
<h1 align="center">tmux-smooth-scroll</h1>

<p align="center">
  Smooth scrolling for tmux—makes scrolling easy to follow.
</p>

<p align="center">
<img width="50%" src="https://github.com/user-attachments/assets/c1e816a8-411c-44c5-8b15-97c70dcf7248"></img>
</p>

<br>

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

Optional settings in `~/.tmux.conf`:

```tmux
# Speed: 0-1000 | lower = faster
set -g @smooth-scroll-speed "50"

# Scroll line distance
set -g @smooth-scroll-normal "3"
set -g @smooth-scroll-halfpage ""  # Default: pane_height / 2
set -g @smooth-scroll-fullpage ""  # Default: pane_height

# Mouse wheel smooth scrolling
set -g @smooth-scroll-mouse "true"
```

