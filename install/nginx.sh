#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

clear
echo "========================================================================="
echo "install Nginx"
echo "========================================================================="

nv=`/usr/local/nginx/sbin/nginx -v 2>&1`
old_nginx_version=`echo $nv | cut -c22-`

