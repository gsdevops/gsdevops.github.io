
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

mkdir -p /home/USER_HOME/.ssh 

cat - > /home/USER_HOME/.ssh/authorized_keys <<EOF 

ssh-rsa ---the-rest-of-the_KEY_FILE-till-the-eof-marker 

EOF 

chmod 600 /home/USER_HOME/.ssh/authorized_keys 

* tunnelling: 

``` shell  
ssh  -L 1234:localhost:6667:server.example.com
``` 

 

Fingerprint PEM files: 

openssl rsa -in query.pem -pubout -outform DER | openssl md5 -c 

 

