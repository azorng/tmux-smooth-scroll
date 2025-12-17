#!/usr/bin/env perl
# Smooth scroll animation with easing
use strict;
use warnings;
use Time::HiRes qw(usleep);
use POSIX qw(ceil);
use constant PI => 3.14159265359;

my ($base_delay, $lines, $direction, $mode) = @ARGV;

# Easing functions - return velocity factor (higher = faster, lower delay)
sub linear {
    return 1.0;
}

sub sine {
    my $t = shift;  # progress 0.0 to 1.0
    # Sine curve: slower at edges, faster in middle (0.3x -> 3x range)
    my $velocity = sin($t * PI);
    return 0.3 + $velocity * 2.7;
}

sub quad {
    my $t = shift;  # progress 0.0 to 1.0
    # Quadratic ease in-out: slow start/end, aggressive middle (0.2x -> 3x range)
    my $velocity;
    if ($t < 0.5) {
        $velocity = 2 * $t * $t;
    } else {
        $velocity = 1.0 - ((-2 * $t + 2) ** 2) / 2;
    }
    return 0.2 + $velocity * 2.8;
}

# Calculate delay for each step (inverse of velocity)
sub get_delay {
    my ($i, $total, $mode) = @_;
    my $t = ($total > 1) ? $i / ($total - 1) : 0.0;  # Progress: 0.0 to 1.0
    
    my $velocity;
    if ($mode eq 'linear') {
        $velocity = linear();
    } elsif ($mode eq 'quad') {
        $velocity = quad($t);
    } else {  # sine (default)
        $velocity = sine($t);
    }
    
    # Scale delay inversely with line count to maintain consistent animation duration
    # More lines = faster per-step, fewer lines = slower per-step
    my $scale_factor = 1.0;
    if ($total > 0 && $total < 10) {
        # Smooth curve: 1 line = 3x slower, 10 lines = 1x (normal speed)
        $scale_factor = 1.0 + (2.0 * (10 - $total) / 9);
    }
    
    # Higher velocity = shorter delay
    return ($base_delay * $scale_factor) / $velocity;
}

# Execute animation
for (my $i = 0; $i < $lines; $i++) {
    system("tmux", "send-keys", "-X", "scroll-" . $direction);
    
    # Don't delay after last scroll
    if ($i < $lines - 1) {
        my $delay = get_delay($i, $lines, $mode);
        usleep(ceil($delay));
    }
}
