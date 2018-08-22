# Regex 
Using regex in if-else statements
```shell
if [[ ${file_name} != *".tar.gz" ]]; then
    echo "more code here"
fi
```

Extracting/Removing substrings from another string (more [here](https://www.tldp.org/LDP/abs/html/string-manipulation.html))
* from the start of the originating string
```shell
long_var='Codename:	trusty'
short_var=${long_var#Codename:*}
```

* from the end of the originating string
```shell
long_var='test_archive.zip'
short_var=${long_var%\.zip}
```


# Crontab
Switching users
```shell
crontab -u ubuntu -l
```

Updating a crontab programmatically
```shell
(crontab -l 2>/dev/null; echo -e "*/5 * * * * /run/my/script\n") | crontab -;
```


# Date/Time Operations
Utilizing the date function
```shell
date -d "2 days ago" 

$(date +"%Y-%m-%d--%H-%M") 
```


# Terminal UI
Removing color coding
```shell
tail - file |  sed  -u 's/\x1B\[[0-9;]*[JKmsu]//g'
```


# CURL 
Create a new file, curl-format.txt, and paste in
```shell
    time_namelookup:  %{time_namelookup}\n 
       time_connect:  %{time_connect}\n 
    time_appconnect:  %{time_appconnect}\n 
   time_pretransfer:  %{time_pretransfer}\n 
      time_redirect:  %{time_redirect}\n 
 time_starttransfer:  %{time_starttransfer}\n 
                    ----------\n 
         time_total:  %{time_total}\n 
``` 

Make a request
```shell
curl -w "@curl-format.txt" -o /dev/null -s "http://wordpress.com/"
```


# PEM Files
Create fingerprint PEM file 
```
openssl rsa -in query.pem -pubout -outform DER | openssl md5 -c
```


# Multi Processing
Shell locking to prevent concurrent execution
```shell 
flock -n -c command
```


# NTP
Install NTP and synchronize the system with the NTP server
```shell
apt-get install -y ntp 
service ntp stop
ntpd -gq
service ntp start
timedatectl
```


# Finding files (the `find` command):
```bash
# find files based on modification time 
find ./* -type f -mtime +${days}

# Find files with special owner
find /home/ubuntu/.m2/ -user root

```

# Shell execution detection
Checking if a script is sourced or subshelled:  
`[[$0!="$BASH_SOURCE"]]||(echo"This script should be sourced. use'source$0'";exit1)` 

# Find lines with non ascii chars:
```shell 
grep --color='auto' -P -n '[^\x00-\x7F]' FILENAME
```

