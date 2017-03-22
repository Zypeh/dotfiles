#! /usr/bin/env bash

# This script is used to run shell scripts when the system boots.
# add this to your crontab
#
# $ crontab -e
# 
# @reboot <user_name> /bin/bash /home/<user_name>/init.sh
#

cd /home/zypeh
if [ -d ".config" ]; then
	. .config/bootstrap.sh
fi

