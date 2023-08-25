#!/bin/bash

-set -euo pipefail

# This script works only with DTS 5.1

DTS_FILE_NAME="$1"
DTS_VERSION="$2"

if [ "$DTS_VERSION" = "5.1" ]
then
  ffmpeg \
    -i "$DTS_FILE_NAME" \
    -filter_complex "channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR]" \
    -map "[FL]" "${DTS_FILE_NAME}_front_left.wav" \
    -map "[FR]" "${DTS_FILE_NAME}_front_right.wav" \
    -map "[FC]" "${DTS_FILE_NAME}_front_center.wav" \
    -map "[LFE]" "${DTS_FILE_NAME}_lfe.wav" \
    -map "[BL]" "${DTS_FILE_NAME}_back_left.wav" \
    -map "[BR]" "${DTS_FILE_NAME}_back_right.wav"
fi

if [ "$DTS_VERSION" = "7.1" ]
then
  ffmpeg \
    -i "$DTS_FILE_NAME" \
    -filter_complex "channelsplit=channel_layout=7.1[FL][FR][FC][LFE][BL][BR][FLC][FRC]" \
    -map "[FL]" "${DTS_FILE_NAME}_front_left.wav" \
    -map "[FR]" "${DTS_FILE_NAME}_front_right.wav" \
    -map "[FC]" "${DTS_FILE_NAME}_front_center.wav" \
    -map "[LFE]" "${DTS_FILE_NAME}_lfe.wav" \
    -map "[BL]" "${DTS_FILE_NAME}_back_left.wav" \
    -map "[BR]" "${DTS_FILE_NAME}_back_right.wav" \
    -map "[FLC]" "${DTS_FILE_NAME}_front_left_center.wav" \
    -map "[FRC]" "${DTS_FILE_NAME}_front_right_center.wav"
else
  printf "This script supports only DTS version 5.1 and 7.1"
fi
