#!/bin/bash

#
# DESCRIPTION
#     Generate word frequence list from subtitles (.srt) and save it to text file.
#     The output looks as follows:
#     1 grew
#     1 grid
#     2 press
#     3 lie
#     ...
#     355 the
#     617 I
#          
#
# SYNTAX 
#       <path to .srt file>
#     - example: ./script ./mission_impossible/sub/sub_en.srt
#

set -euo pipefail

PATH_TO_SUBTITLES="$1"

grep \
  --extended-regexp "\w+" \
  "$PATH_TO_SUBTITLES" | tr -cs "a-zA-Z" "\n" | sort | uniq -c | sort -n > words.txt

