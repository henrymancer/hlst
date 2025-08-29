#!/bin/sh
echo "This is not a real implementation."

# Clone all files from the Git Repository
git clone https://github.com/henrymancer/hlst.git /tmp/hlst

# Copy user config files
cp /tmp/hlst/user-config/* ~/
