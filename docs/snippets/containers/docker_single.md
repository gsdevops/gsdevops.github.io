# user permissions on docker host

```shell
sudo usermod -aG docker $THE_USER
``` 


# image and container cleanup
remove unused images:  
```shell
docker rmi $(docker images | grep "<none>" | awk '{print $3}') 
```

remove unused container processes:  
```shell
docker rm $(docker ps -a| grep Exited | awk '{print $1}') 
```


# ecr login:
 to connect the docker pull/push commands to the ECR repos
`aws ecr get-login --region ${1:-$AWS_REGION} | sed 's/-e none//'` 