# General SSH
SSH key generation
```shell 
ssh-keygen -t rsa -C "your_email@example.com"
``` 

Add SSH key to server 
```shell
mkdir -p /home/USER_HOME/.ssh 

cat - > /home/USER_HOME/.ssh/authorized_keys <<EOF 
ssh-rsa ---the-rest-of-the_KEY_FILE-till-the-eof-marker 
EOF 

chmod 600 /home/USER_HOME/.ssh/authorized_keys 
```

SSH tunnelling command 
```shell  
ssh  -L 1234:localhost:6667:server.example.com
```

## SSH Configuration Files  
SSH key file, and avoid the known hosts duplicates 
```shell
Host hostname-suffix.sfx
    IdentityFile ~/.ssh/KEY_FILE
    UserKnownHostsFile /dev/null
    CheckHostIP no
    StrictHostKeyChecking no
```

Tunnelling
```shell
Host lsTnl
    HostName abc.gsdevops.com
    User ubuntu
    IdentityFile ~/.ssh/KEYFILE 
    LocalForward 30080 localhost:80
    LocalForward 9200 localhost:9200
```

Then issue the following command
`ssh lsTnl`
