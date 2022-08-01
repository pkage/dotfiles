 #!/usr/bin/bash

# Define the clock
Clock() {
        DATETIME=$(date "+%a %b %d, %T")

        echo -n "$DATETIME"
}

# Get the current workspace
Workspaces() {
    bspc wm -g | bspbar-windows | tr -d '\n'

}

WindowTitle() {
    xtitle `bspc query -N -d focused -n .focused.window`
}

# Caffeinated?
Caffeine() {
    echo "no"
    # if caffeine query; then
    #     echo -n "caffeinated"
    # else
    #     echo -n ""
    # fi
}

# Print the status line
while true; do
    echo "%{l}%{F#cccccc}%{B#000000} $(Workspaces)%{c}$(WindowTitle)%{r}%{F#888888}$(Caffeine)  %{F#cccccc}$(Clock) %{F-}%{B-}"
        sleep 0.1
done
