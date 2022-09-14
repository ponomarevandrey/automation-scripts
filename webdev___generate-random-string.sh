#!/bin/bash

# Source: https://unix.stackexchange.com/questions/230673/how-to-generate-a-random-string

tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 13  ; echo
