#!/bin/bash

# Always run with 'sudo'.

echo "======================="
echo "=== Uninstall Nginx ==="
echo "======================="

echo "Remove everything including config files in '/etc/nginx'"
sudo apt-get purge nginx nginx-common

echo 

echo "Remove dependencies used by nginx which are no longer required"
sudo apt autoremove
