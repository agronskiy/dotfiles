#!/bin/sh
#
# Print a 256-color number derived from a stable hash of the hostname.
# Used by tmux.conf.symlink to color-code the session name per host.

set -eu

# Mild dark 256-color palette: bordeaux, dark blue, dark orange/brown,
# dark green, dark purple.
COLORS="52 17 94 22 53"

H=$(hostname)
SUM=$(printf "%s" "$H" | cksum | awk '{print $1}')
N=$(echo "$COLORS" | wc -w)
IDX=$(( SUM % N + 1 ))
echo "$COLORS" | awk -v i="$IDX" '{print $i}'
