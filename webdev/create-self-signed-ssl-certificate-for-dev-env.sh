#!/bin/bash

# DESCRIPTION
#     Create self-signed SSL certificate.
#     The script is for local development environment!
#
# SYNTAX 
#       <server name> <output path>
#     - example: ./script test.com ./nginx/certs

set -eu

URL="$1"
OUTPUT_PATH="$2"

openssl req \
  -newkey rsa:2048 \
  -x509 \
  -nodes \
  -keyout "$OUTPUT_PATH/$URL.key" \
  -new \
  -out "$OUTPUT_PATH/$URL.crt" \
  -subj "/CN=$URL" \
  -reqexts SAN \
  -extensions SAN \
  -config <(cat /usr/lib/ssl/openssl.cnf \
    <(printf '[SAN]\nsubjectAltName=DNS:localhost')) \
  -sha256 \
  -days 3650

echo "Done. Created two files: "
ls -F "$OUTPUT_PATH"

