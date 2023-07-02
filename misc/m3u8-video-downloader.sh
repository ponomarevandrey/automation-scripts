#!/bin/bash

#
# DESCRIPTION
#     Download m3u8 video files
#
# SYNTAX 
#       <input file name> <output file name>
#     - example: ./script "https://website.com/video.m3u8[optional params]" "Output file name.mp4"

set -euo pipefail

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if \
  ffmpeg \
    -i "$INPUT_FILE" \
    -c copy \
    -bsf:a aac_adtstoasc \
    "$OUTPUT_FILE"; \
then \
  echo -e "\nDone. Video successfully saved to '$OUTPUT_FILE'"
else 
  echo "Error. Something went wrong"
fi
