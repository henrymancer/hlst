#!/bin/sh

BIN_DIR=$HOME/.local/bin

print_header() {
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

print_header "STARTING HLST CONFIGURATION"
set -x

# Clone all files from the Git Repository
git clone https://github.com/henrymancer/hlst.git /tmp/hlst

# Copy user config files
cp /tmp/hlst/user-config/.* $HOME
set +x

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    # Add the directory to PATH
    export PATH="$PATH:$BIN_DIR"
    # Add directory to PATH in ~/.bashrc
    echo 'export PATH="$PATH:'$BIN_DIR'"' >> $HOME/.bashrc
    echo "Added $BIN_DIR to PATH."
fi

cp /tmp/hlst/bin/* $BIN_DIR
chmod +x -R $BIN_DIR

print_header "CONFIGURATION COMPLETED. REMOVING TMPDIR"

# Remove all temporary files
rm -rf /tmp/hlst
