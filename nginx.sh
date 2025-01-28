#!/bin/bash

# [Cleanup] Remove all files in the temporary directory
rm -rf /home/container/tmp/*

# [Docker] Starting NGINX
echo "[Docker] Starting NGINX"
echo "[Docker] Services successfully launched"

nginx -c /home/container/nginx/nginx.conf -p /home/container
