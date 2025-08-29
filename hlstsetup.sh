#!/bin/sh

BIN_DIR=$HOME/.local/bin
INSTALLINFO="$HOME/.local/var/hlst/installinfo"

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

track_cp() {
    src="$1"
    dest="$2"

    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"

    echo "$src -> $dest"
    echo "$src -> $dest" >> "$INSTALLINFO"
}

track_cp_dir() {
    src_dir="$1"
    dest_dir="$2"

    find "$src_dir" -type f | while read -r src_file; do
        # Compute relative path from source directory
        rel_path="${src_file#$src_dir/}"

        # Construct destination path
        dest_file="$dest_dir/$rel_path"

        # Use your tracking copy function
        track_cp "$src_file" "$dest_file"
    done
}

remove_old_install() {
    if [ -f "$INSTALLINFO" ]; then
        print_header "REMOVE OLD INSTALL"

        while read -r line; do
            # Use awk to split on ' -> '
            src=$(echo "$line" | awk -F ' -> ' '{print $1}')
            dest=$(echo "$line" | awk -F ' -> ' '{print $2}')

            # Skip malformed lines
            [ -z "$dest" ] && continue

            if [ -e "$dest" ]; then
                rm -rf "$dest"
                echo "Removed: $dest"
            else
                echo "Not found: $dest"
            fi
        done < "$INSTALLINFO"
        > "$INSTALLINFO"
        echo "Install info cleared."
    else
        echo "No install info file found."
    fi
    echo "Proceeding with installation."
}

mkdir -p "$(dirname "$INSTALLINFO")"
touch "$INSTALLINFO"
remove_old_install

print_header "STARTING HLST CONFIGURATION"

# Clone all files from the Git Repository
set -x
git clone https://github.com/henrymancer/hlst.git /tmp/hlst
set +x

# Change directory to the cloned repo
cd /tmp/hlst

# Copy user config files
track_cp_dir user-config $HOME

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    # Add the directory to PATH
    export PATH="$PATH:$BIN_DIR"
    # Add directory to PATH in ~/.bashrc
    echo 'export PATH="$PATH:'$BIN_DIR'"' >> $HOME/.bashrc
    echo "Added $BIN_DIR to PATH."
fi

track_cp_dir bin $BIN_DIR
chmod +x -R $BIN_DIR

print_header "CONFIGURATION COMPLETED. REMOVING TMPDIR"

# Remove all temporary files
rm -rf /tmp/hlst
