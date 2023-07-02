#!/bin/bash

#
# DESCRIPTION
#     Removes old revisions of snaps
# 
# NOTES
#     - close all snaps before running this
#

set -euo pipefail
printenv
set -x



LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
  while read snapname revision; do
    snap remove "$snapname" --revision="$revision"
  done
  
  
  
set +x

echo "Done. Old snaps removed."
