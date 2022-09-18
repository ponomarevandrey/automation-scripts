#!/bin/bash

#
# DESCRIPTION
#     Removes old revisions of snaps
# 
# NOTES
#     - close all snaps before running this
#

set -eu
# For cron job debugging
printenv
set -x



LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
  while read snapname revision; do
    snap remove "$snapname" --revision="$revision"
  done
  
  
  
set +x
