#!/bin/bash

#
# DESCRIPTION
#     Removes all configuration files left after removal of packages
#

dpkg -l | grep '^rc' | awk '{print $2}' | sudo xargs dpkg --purge
