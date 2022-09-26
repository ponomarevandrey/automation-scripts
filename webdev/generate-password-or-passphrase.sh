#!/bin/bash

#
# Generate a hex-string that can be used as a password or passphrase.
#
# - for passwords
#   take at least 23 characters from the beginning of the output
# - for passphrases for keys (e.g. GPG or SSH keys)
#   take at least 20 characters
#
# To take the aforemention number of first characters, pipe to
# `head -c 20 yourFile.txt`
#

dd if=/dev/urandom bs=32 count=1 2>/dev/null | sha256sum -b | sed 's/ .*//'
