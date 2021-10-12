#! /bin/bash

export MONITOR_PRIMARY=DP-0
export MONITOR_SECONDARY=DP-2
export MONITOR_TERTIARY=DP-4

export MULTIMONITOR=0

dualmonitormode=$(xrandr --query | grep " connected" | wc -l)
if [[ $dualmonitormode = 2 ]]
then
    # xrandr --output LVDS1 --primary --mode 1366x768 --rotate normal --output VGA1 --mode 1920x1080 --rotate normal --right-of LVDS1
    export MULTIMONITOR=2
    xrandr \
        --output $MONITOR_PRIMARY --primary \
        --mode  2560x1440 \
        --rotate normal \
        --output $MONITOR_SECONDARY \
        --mode  2560x1440 \
        --rotate left \
        --right-of $MONITOR_PRIMARY

    echo "dual monitors detected"
elif [[ $dualmonitormode = 3 ]]
then
    echo "triple monitors detected"
    export MULTIMONITOR=3

    xrandr --output $MONITOR_PRIMARY --primary \
        --mode 2560x1440 \
        --rotate normal \
        --output $MONITOR_TERTIARY \
        --mode 1920x1080 \
        --rotate left \
        --left-of $MONITOR_PRIMARY \
        --output $MONITOR_SECONDARY \
        --mode  2560x1440 \
        --rotate right \
        --right-of $MONITOR_PRIMARY
else
    echo "nop"
fi

