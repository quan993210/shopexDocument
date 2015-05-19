#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
		echo "Error : You must be root to run this script, please use root to install mysql"
		exit 1
fi

clear

echo "=================================================="
echo "ecstore mysql for CentOS/RadHat Linux Server"
echo "=================================================="

cur_dir=$(pwd)

#set mysql root password
	echo "=================================="
	
	mysqlrootpwd="root"
	echo "Please input the root password of mysql:"
	read -p "(Default password: root):" mysqlrootpwd
	if [ "$mysqlrootpwd" = "" ]; then
			mysqlrootpwd="root"
	fi
	echo "=================================="
	echo "Mysql root password :$mysqlrootpwd"
	echo "=================================="

# do you want to install the InnoDB Storage Engine?




