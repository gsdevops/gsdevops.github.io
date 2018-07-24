#!/bin/bash

#####
# description: script for installing the AWS perl-based disk and memory metric monitoring/upload scripts
# template: ./install_monitoring.sh <application name> <environment name> <disk path to monitor> <client name>
# usage: sudo ./install_monitoring.sh mongodb performance /mongo/ Google
#####


# Initial tests
if [ "$EUID" -ne 0 ]; then
  echo -e "\nERROR: run the script as root\n=========="
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
app_name="${1:-testapp}"
env="${2:-staging}"
disk_path="${3:-/}"
client="${4:-GS}"


# Installation blocks
echo -e "\nsetting up monitoring directory and packages\n##########"
mkdir /opt/monitoring; test_status $?
apt-get update; test_status $?
apt-get install -y libwww-perl libdatetime-perl unzip; test_status $?

echo -e "\ndownloading and installing monitoring scripts\n##########"
wget -P /opt http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip; test_status $?
unzip -d /opt /opt/CloudWatchMonitoringScripts-1.2.1.zip;  test_status $?
mv /opt/aws-scripts-mon/* /opt/monitoring/; test_status $?

echo -e "\ncleaning up the work environment\n##########"
rm -r /opt/aws-scripts-mon /opt/CloudWatchMonitoringScripts-1.2.1.zip; test_status $?

echo -e "\nupdating the namespace for metric uploads\n##########"
sed -i "s/System\/Linux/${client}Mon\/${env}-${app_name}/" /opt/monitoring/mon-put-instance-data.pl; test_status $?

echo -e "\nupdating the crontab\n##########"
(crontab -l 2>/dev/null; echo -e "*/5 * * * * /opt/monitoring/mon-put-instance-data.pl --disk-space-util --disk-path=${disk_path} --from-cron\n") | crontab -; test_status $?


exit 0