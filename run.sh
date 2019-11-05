#!/bin/bash
# Author: Yevgeniy Goncharov aka xck, http://sys-adm.in
# Script for first run after installed CentOS servers
# Install necessary tools, remove unused software

# Sys env / paths / etc
# -------------------------------------------------------------------------------------------\
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

# Firs steps
# -------------------------------------------------------------------------------------------\

# Remove unused software
yum erase iwl* -н

# Update system
yum update -y 

# Install software
yum install git nano wget net-tools epel-release -y


read -p "Install Rmate? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    wget -O- https://raw.githubusercontent.com/m0zgen/install-rmate/master/install-rmate.sh | bash
fi

read -p "Secure SSH? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    wget -O- https://raw.githubusercontent.com/m0zgen/secure-ssh/master/secure-ssh.sh | bash
fi

exit 0