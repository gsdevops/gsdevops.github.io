



# Kubectl:

### List pods:
```bash
kubectl get pods 

#  wide view
kubectl get pods -o wide


```


kubectl run mongo-proxy --replicas=1 --labels="run=load-balancer-example" --image=eu.gcr.io/testing-211007/mongo/mongo-proxy:1.0.0  --port=27017



kubectl run mongo-proxy2 --replicas=1 --labels="run=load-balancer-example" --image=eu.gcr.io/testing-211007/mongo/mongo-proxy:1.0.0  --port=27017



kubectl expose deployment  mongo-proxy --type=LoadBalancer --name=my-mongo-proxy 
kubectl expose deployment  mongo-proxy --type=LoadBalancer --name=my-mongo-proxy2 



kubectl set image deployment/mongo-proxy2 nginx=nginx:1.9.1 --record
