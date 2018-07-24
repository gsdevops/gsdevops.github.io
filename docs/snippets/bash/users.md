# Linux Users 

Creates a home folder, with default shell as bash, and the username ubuntu 
```shell 
useradd  -m -s /bin/bash -Gsudo,cdrom ubuntu
```

Add a user to an existing group  
```shell
useradd -G {group-name} username
``` 

Execute a command as a different user 
```
sudo -u tomcat7 cp *.war /var/lib/tomcat7/webapps
```

Sudo without password 
```shell 
echo "ALL ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```
