#!/bin/bash

#
# DESCRIPTION
#     Removes all configuration files left after removal of packages
#

# If this script runs as a cron job and doesn't find anything to purge, it will return an error and cron job will fail. To prevent this we supress error output by sending it to /dev/null

-set -euo pipefail
-printenv

set -x



dpkg -l | \
grep '^rc' | \
awk '{print $2}' | \
sudo xargs dpkg --purge



set +x
