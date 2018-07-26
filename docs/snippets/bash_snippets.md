# gsdevops.github.io
[https://gsdevops.github.io/](https://gsdevops.github.io/)


# Bash functions 

```shell
function myfunc() 
{ 
    local  myresult='some value' 
    echo "$myresult" 
} 
 
result=$(myfunc)   # or result=`myfunc` 
echo $result 

```

# Date and time
```shell
date -d "2 days ago" 

$(date +"%Y-%m-%d--%H-%M") 
```

# Bash remove color coding 

`tail - file |  sed  -u 's/\x1B\[[0-9;]*[JKmsu]//g'` 

#CURL + latency: 

Create a new file, curl-format.txt, and paste in: 
```
    time_namelookup:  %{time_namelookup}\n 
       time_connect:  %{time_connect}\n 
    time_appconnect:  %{time_appconnect}\n 
   time_pretransfer:  %{time_pretransfer}\n 
      time_redirect:  %{time_redirect}\n 
time_starttransfer:  %{time_starttransfer}\n 
                    ----------\n 
         time_total:  %{time_total}\n 
``` 

Make a request: 
```
curl -w "@curl-format.txt" -o /dev/null -s "http://wordpress.com/"
```
 

# Linux users 
*creates home folder, shell is bash and user is ubuntu 
```shell useradd  -m -s /bin/bash -Gsudo,cdrom ubuntu```   
* add user to existing group  
```useradd -G {group-name} username``` 

Execute as a different user 

```
sudo -u tomcat7 cp *.war /var/lib/tomcat7/webapps
```

* Sudo wo password 

```shell 
echo "ALL ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```  
 
 
# SSH stuff  

* SSH Keys generation: 

``` shell ssh-keygen -t rsa -C "your_email@example.com" ``` 

 

Add key to server 
```shell
mkdir -p /home/USER_HOME/.ssh 

cat - > /home/USER_HOME/.ssh/authorized_keys <<EOF 
ssh-rsa ---the-rest-of-the_KEY_FILE-till-the-eof-marker 
EOF 

chmod 600 /home/USER_HOME/.ssh/authorized_keys 
```

## ssh config file  
* SSH key file, and avoid the known hosts duplicates 
```shell 
Host hostname-suffix.sfx
    IdentityFile ~/.ssh/KEY_FILE
    UserKnownHostsFile /dev/null
    CheckHostIP no
    StrictHostKeyChecking no
```
* tunnelling:  
```shell
Host lsTnl
    HostName abc.gsdevops.com
    User ubuntu
    IdentityFile ~/.ssh/KEYFILE 
    LocalForward 30080 localhost:80
    LocalForward 9200 localhost:9200
```
and then just:
`ssh lsTnl`


* tunnelling command 

``` shell  
ssh  -L 1234:localhost:6667:server.example.com
``` 

 

Fingerprint PEM files: 

```
openssl rsa -in query.pem -pubout -outform DER | openssl md5 -c
```

# crontab
for other user
```shell
crontab -u ubuntu -l```

# Multi processing:
shell locking to prevent concurrent execution:
```shell 
flock -n -c command
```  

# Shell execution detection
Checking if a script is sourced or subshelled:  
`[[$0!="$BASH_SOURCE"]]||(echo"This script should be sourced. use'source$0'";exit1)` 

