#!/bin/sh

# 
# DESCRIPTION
#      Run this script when you create a new VPS. It creates a new user, 
#      enables SSH for him, allows new user to execute commands as "root" and
#      disables password and SSH login for "root". 
#      After running this script you'll be able to SSH into VPS ONLY with 
#      "ssh new_username@VPS_IP"
#
# SYNTAX
#     <NEW USER NAME> <NEW USER PASWORD>
#
#     - example: ./script "ikar" "123456" (always use quotation marks!)
#
# BEFORE RUNNING THIS SCRIPT
#
#     1. If on attempt to SSH into server you get "WARNING: REMOTE HOST 
#        IDENTIFICATION HAS CHANGED!", delete hashed hosts with 
#        "ssh-keygen -R 192.168.3.10"
#
#     2. Make sure that you have generated your SSH keys and they are in 
#        "~/.ssh" directory (default location)
#
#     3. Copy public SSH key to your VPS to enable SSH for "root" with 
#        "ssh-copy-id root@192.168.3.10"
#
# HOW TO USE
#
#     Always run this script with root permissions (i.e. log in as "root"
#     or use "sudo" before the script name)
#
#     1. Copy this script to VPS: 
#        rsync \
#          --progress \
#          --verbose \
#          --archive \
#          --rsh=ssh \
#        ./script "root@192.168.3.10:/"
#
#     3. Execute the scrip
#

set -eu



USERNAME="$1"
PASSWORD="$2"

echo "1. Add new user."
useradd \
  --create-home \
  --shell /bin/bash \
  "$USERNAME"

echo "2. Set new user password."
echo "$USERNAME":"$PASSWORD" | chpasswd

echo

echo "3. Allow new user to execute commands as 'root' i.e. to use 'sudo'."
usermod \
  --append \
  --groups sudo achilles

echo

echo "4. Move root '.ssh' to new user."
mv \
  /root/.ssh \
  /home/achilles/

echo

echo "5. Change the ownership of the '.ssh' dir from 'root' to new user so OpenSSH can read it."
chown \
  --recursive \
  achilles:achilles /home/achilles/.ssh
    
echo 
   
echo "6. Disable the 'root' account login (both via password ans via SSH)."
passwd \
  --delete \
  --lock \
  root
  
echo
