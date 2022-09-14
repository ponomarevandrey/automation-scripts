#!/bin/bash

# DESCRIPTION
#     Convert multiple .wv files into .flac files
#
# NOTES
#     Run this script in directory containing .wv files

set -eu

check_dependencies () {
  dependencies=( "ffmpeg" "flac")

  for i in "${dependencies[@]}"; do
    if ! command -v $i &> /dev/null; then 
      echo "${i} required" && exit 1
    fi
  done
}

convert_wv_to_flac () {
  for wv_file in *.wv; do 
    flac_file="$(echo "$wv_file" | sed s/.wv/.flac/)"
    ffmpeg \
      -hide_banner \
      -loglevel error \
      -i "$wv_file" "$flac_file"
  done

  read -p $'\nDo you want to delete _source_ wv files? [Yy/Nn] '
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm --verbose *.wv
  fi 
}

check_dependencies
wv_to_flac
