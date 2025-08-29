#!/bin/sh
# Print a warning if any disk is more than 90% (default).
# Allow a different threshold to be set with -t##.
# Allow a list of disks to be passed as arguments if not all should be checked.

# Default threshold
threshold=90

# Parse arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -t*)
            threshold="${1#-t}"
            ;;
        *)
            disks="$disks $1"
            ;;
    esac
    shift
done

# Get disk status, remove "%" symbols, and check against threshold
df $disks | tr -d '%' | awk '
# Only look at lines where the first field contains a "/"
BEGIN { print "Filesystem", "Use%", "Mounted-on"}
$1 ~ /\// {
    if ($5 >= '$threshold') {
        print $1, $5 "%", $6;
    }
}
'
