#!/bin/bash

#
# DESCRIPTION
#     Download m3u8 video files
#
# SYNTAX 
#       <input file name> <output file name>
#     - example: ./script "https://website.com/video.m3u8" "Output file name.mp4"

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if \
  ffmpeg \
    -protocol_whitelist file,http,https,tcp,tls,crypto \
    -i "$INPUT_FILE" \
    -c copy "$OUTPUT_FILE"; \
then \
  echo "Done. Video successfully saved to '$OUTPUT_FILE'"
else 
  echo "Error. Something went wrong"
fi
