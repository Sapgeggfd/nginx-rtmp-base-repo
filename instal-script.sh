#!/bin/bash

# [SETUP] Install necessary packages, including git
echo -e "[SETUP] Install packages"
apt-get update -qq > /dev/null 2>&1 && apt-get install -qq > /dev/null 2>&1 -y git wget perl perl-doc fcgiwrap

# Change to server directory
cd /mnt/server

# [SETUP] Create necessary folders
echo -e "[SETUP] Create folders"
mkdir -p logs tmp

# Clone the default repository into a temporary directory
echo "[Git] Cloning default repository 'https://github.com/Sapgeggfd/nginx-rtmp-base-repo' into temporary directory."
git clone https://github.com/Sapgeggfd/nginx-rtmp-base-repo /mnt/server/gtemp > /dev/null 2>&1 && echo "[Git] Repository cloned successfully." || { echo "[Git] Error: Default repository clone failed."; exit 21; }

# Copy the www folder and files from the temporary repository to the target directory
echo "[Git] Copying folder and files from default repository."
cp -r /mnt/server/gtemp/nginx /mnt/server || { echo "[Git] Error: Copying 'nginx' folder failed."; exit 22; }
cp /mnt/server/gtemp/nginx.sh /mnt/server || { echo "[Git] Error: Copying 'nginx.sh' file failed."; exit 22; }
chmod +x /mnt/server/nginx.sh

# Remove the temporary cloned repository
echo "[Git] Clearing temporary folder."
rm -rf /mnt/server/gtemp
