#!/bin/bash

# If you get "Missing or invalid Sec-WebSocket-Key header" error, just try to pass another sec-websocket-key

curl \
  --include \
  --no-buffer \
  --header "connection: upgrade" \
  --header "upgrade: websocket" \
  --header "host: localhost" \
  --header "origin: http://localhost:8080" \
  --header "sec-websocket-key: dGhlIHNhbXBsZSBub25jZQ==" \
  --header "sec-websocket-version: 13" \
  http://localhost:8080

echo
