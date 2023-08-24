#!/bin/bash

# DESCRIPTION
#     Splits FLAC, APE or WV using CUE sheet. 
#     If the file is not FLAC, it also converts it to FLAC. The script also
#     copies ID3v2 metadata from CUE sheet to each audio file.
#
# SYNTAX 
#     - to split audio file using CUE sheet: 
#       <FLAC filename or full path> <CUE filename or full path>
#     - example: ./script Pete Namlook & Dr. Atmo ‎– Silence.flac \
#                         Pete Namlook & Dr. Atmo ‎– Silence.cue
#
# NOTES
#     - concerning the subject of quality loss while ecoding/decoding
#       https://superuser.com/questions/447338/understanding-conversion-and-decompression-of-lossless-audio

set -euo pipefail

check_dependencies () {
  dependencies=( "ffmpeg" "iconv" "shnsplit" "flac" "cuetag" )

  for i in "${dependencies[@]}"; do
    if ! command -v $i &> /dev/null; then 
      echo "${i} required" && exit 1
    fi
  done
}

split_flac () {
  echo -e "\n*** Split FLAC ***"

  echo -e "\n- Split audio file using CUE sheet"
  echo "$AUDIO_NAME.flac"
  shnsplit \
    -f "$CUE_PATH" \
    -t "%n. %p - %t" \
    -o flac \
    "$AUDIO_NAME.flac"
  
  echo -e "\n- Copy ID3v2 tags from CUE sheet to each audio file"
  cuetag "$CUE_PATH" [[:digit:]]*.flac
}

convert_to_flac () {
  echo -e "\n*** Convert source audio to FLAC ***"

  # `shnsplit` can convert APE to FLAC directly, but that requires us to 
  # install extra package - APE codec 
  # (https://github.com/fernandotcl/monkeys-audio). 
  # So instead of using `shnsplit` at this step I just use `ffmpeg` and `flac`.

  echo -e "\n- Convert to WAV"
  ffmpeg \
    -hide_banner \
    -loglevel error \
    -i "$AUDIO_BASENAME" "$AUDIO_NAME.wav"

  echo -e "\n- Convert WAV to FLAC"
  flac *.wav

  echo -e "\n- Delete intermediate WAV file"
  rm --verbose "$AUDIO_NAME.wav"
}

process_audio () {
  case "$AUDIO_EXTENSION" in
    "flac" )
      split_flac
      ;;
    "wv" | "ape" )
      convert_to_flac
      split_flac
      echo -e "\n- Delete intermediate FLAC file"
      rm --verbose "$AUDIO_NAME.flac"
      ;;
    * )
      echo -e "\nUnsupported audio format :(" && exit 1
  esac

  read -p $'\nDo you want to delete _source_ file? [Yy/Nn] '
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm --verbose "$AUDIO_BASENAME"
  fi

  echo -e "\nDone!"
}



check_dependencies

AUDIO_PATH="$1"
CUE_PATH="$2"
AUDIO_BASENAME="$(basename -- "$AUDIO_PATH")"
AUDIO_EXTENSION="${AUDIO_BASENAME##*.}"
AUDIO_NAME="${AUDIO_BASENAME%.*}"

process_audio
