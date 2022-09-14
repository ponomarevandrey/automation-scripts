#!/bin/bash

set -eu

TOKEN="$1"

curl -X GET \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  "https://api.simplecloud.ru/v3/vps?page=1&per_page=10"
