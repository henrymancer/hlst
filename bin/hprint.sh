#!/bin/sh
# Henry's print function
hprint_box_header() {
    local term_width=$(tput cols)
    local text="$1"
    local inner_width=$((term_width - 4))  # Account for box edges
    local padding=$(( (inner_width - ${#text}) / 2 ))
    local remainder=$(( (inner_width - ${#text}) % 2 ))

    # Top border
    printf '┌'
    printf '─%.0s' $(seq 1 "$inner_width")
    printf '┐\n'

    # Middle line with centered text
    printf '│'
    printf ' %.0s' $(seq 1 "$padding")
    printf '%s' "$text"
    printf ' %.0s' $(seq 1 "$((padding + remainder))")
    printf '│\n'

    # Bottom border
    printf '└'
    printf '─%.0s' $(seq 1 "$inner_width")
    printf '┘\n'
}