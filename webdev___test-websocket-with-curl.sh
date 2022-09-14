#!/bin/bash

curl \
  --include \
  --no-buffer \
  --header "connection: upgrade" \
  --header "upgrade: websocket" \
  --header "host: localhost:5000" \
  --header "origin: http://localhost:5000" \
  --header "sec-websocket-key: SGVsbG8sIHdvcmxkIQ==" \
  --header "sec-websocket-version: 13" \
  http://localhos

echo
