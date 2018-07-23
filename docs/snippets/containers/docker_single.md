# user permissions on docker host

```shell
sudo usermod -aG docker $THE_USER
``` 


# image and container cleanup
```shell
docker rmi $(docker images | grep "<none>" | awk '{print $3}') 

docker rm $(docker ps -a| grep Exited | awk '{print $1}') 
```