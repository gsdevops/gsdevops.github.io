#!/bin/bash

#####
# description: script for cleaning up old files
# template: ./file_cleanup.sh <number of days>
# usage: ./file_cleanup.sh 14
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
days="${1:30}"


# Main blocks
echo -e "\nremove the file if it already exists\n##########"
[ -f test.txt ] && rm test.txt; test_status $?

echo -e "finding all files in current directory older than x days and outputting to file\n##########"
for x in `find ./* -type f -mtime +${days}`; do echo "${x}" >> old_files.txt; test_status $?; done

echo -e "deleting all files from the input file\n##########"
while read x; do rm ${x}; test_status $?; done < old_files.txt

exit 0
