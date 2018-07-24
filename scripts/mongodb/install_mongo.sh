#!/bin/bash

#####
# description: installs mongod, mongos, or both on an Ubuntu-based linux distribution server
# template: install_mongo.sh <version number> <install type: clean, upgrade> <mongodb products: mongod, mongos, all>
# usage: ./install_mongo.sh 3.2.1 clean mongos
#####


# Initial tests
if [ "$EUID" -ne 0 ]; then
	echo -e "The script must be run as the Root user\n----------"
	exit 1
fi


# Functions
function test_status {
 if [ $1 -ge 1 ]; then
   echo -e "ERROR: the last command was unsuccessful.\n"
   exit 1
 fi
}


# CLI inputs
mongo_ver="${1:-3.2.19}"
install_type="${2:-clean}"
mongo_type="${3:-mongod}"


# Script variables
mongo_base="${mongo_ver%.*[0-9]}"
codename=`lsb_release -c`
codename=${codename#Codename:*}
echo -e "running ubuntu-${codename}\n##########"


# Installation blocks
echo -e "adding global environment variables\n##########"
echo "LC_ALL=C" >> /etc/environment

echo -e "creating mongo base dir\n##########"
mkdir -p /mongo/{data,logs,keys}; test_status $?

if [ "${install_type}" == "clean" ]; then
	echo -e "performing a clean install\n----------"
	apt-get remove mongodb-org*; test_status $?
else
	echo -e "stopping mongod\n##########"
	mongod --config /etc/mongod.conf --shutdown; test_status $?
	echo -e "performing an upgrade install\n----------"
fi

echo -e "adding source repo information for Mongo ${mongo_ver}\n##########"
if [ "${mongo_base}" == "3.2" ]; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927; test_status $?
elif [ "${mongo_base}" == "3.4" ]; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6; test_status $?
elif [ "${mongo_base}" == "3.6" ]; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5; test_status $?
elif [ "${mongo_base}" == "4.0" ]; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4; test_status $?
else
	echo -e "ERROR - unsupported MongoDB version (${mongo_ver}).\n----------"
	exit 1
fi

echo "deb http://repo.mongodb.org/apt/ubuntu ${codename}/mongodb-org/${mongo_base} multiverse" | tee "/etc/apt/sources.list.d/mongodb-org-${mongo_base}.list"; test_status $?

echo -e "updating apt sources cache\n##########"
apt-get update; test_status $?

echo -e "installing mongo ${mongo_ver}\n##########"
if [ "${mongo_type}" == "mongod" ]; then
	apt-get install -y mongodb-org-server=${mongo_ver} mongodb-org-shell=${mongo_ver} mongodb-org-tools=${mongo_ver}; test_status $?
elif [ "${mongo_type}" == "mongos" ]; then
	apt-get install -y mongodb-org-mongos=${mongo_ver}; test_status $?
else
	apt-get install -y mongodb-org=${mongo_ver}; test_status $?
fi

if [ "${codename}" == "xenial" ]; then
	echo -e "installing systemd file\n##########"
	cat << EOF > /lib/systemd/system/mongod.service
[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target
Documentation=https://docs.mongodb.org/manual

[Service]
User=mongodb
Group=mongodb
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target
EOF
test_status $?
fi
