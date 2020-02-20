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
yum erase iwl* -y

# Update system
yum update -y 

# Install software
yum install git nano wget net-tools epel-release -y

RMATE="/usr/local/bin/rmate"
SSH_SEC=`grep -Po '\bPermitRootLogin\s*\K[^;]*' /etc/ssh/sshd_config | head -1`


# Install cats
wget -O cats.sh https://raw.githubusercontent.com/m0zgen/cats/master/cats.sh && bash cats.sh
rm -f cats.sh

install_rmate()
{
	echo -en "Install Rmate(y/n)? "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
		wget -O install-rmate.sh https://raw.githubusercontent.com/m0zgen/install-rmate/master/install-rmate.sh && bash install-rmate.sh
	    rm -f install-rmate.sh
	fi
}

secure_ssh()
{
	echo -en "Secure SSH?(y/n)? "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
	  wget -O secure-ssh.sh https://raw.githubusercontent.com/m0zgen/secure-ssh/master/secure-ssh.sh && bash secure-ssh.sh
	    rm -f secure-ssh.sh
	fi
}

if [ -f "$RMATE" ]; then
    echo "$RMATE already installed"
else
	install_rmate
fi

if [[ "$SSH_SEC" == "yes" ]]; then
	secure_ssh
else
	echo "Secure SSH already configured!"
fi


exit 0