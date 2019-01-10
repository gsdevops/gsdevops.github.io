

## Controlling the active GCP env
use the `CLOUDSDK_ACTIVE_CONFIG_NAME` env var in the post `$VIRTUAL_ENV/bin/postactivate`  

for the python sdk use: `GOOGLE_APPLICATION_CREDENTIALS` to point to a json credentials file.

### Listing the configurations:
run this to get the list of configurations for your CURRENT shell: `gcloud config configurations list`  


###  Acticating / Adding credentials file
```bash
gcloud auth activate-service-account --key-file KEY_FILE_NAME.json
```


### List the Storage info:  
`gsutil du -s gs://[BUCKET_NAME]`

kubectl config get-contexts

### Get kubectl creds from GCP:
```bash
gcloud container clusters get-credentials
```

and auth the docker cli:
```bash
gcloud auth configure-docker
```

pip install --upgrade google-api-python-client


To install or remove components at your current SDK version [214.0.0], run:
  $ gcloud components install COMPONENT_ID
  $ gcloud components remove COMPONENT_ID

To update your SDK installation to the latest version [214.0.0], run:
  $ gcloud components update

## GCP - K8s:  
Create node pool:
```bash
gcloud container node-pools create preemtible-pool \
  --cluster $CLUSTER_NAME \
  --zone $CLUSTER_ZONE \
  --scopes cloud-platform \
  --enable-autoupgrade \
  --preemptible \
  --num-nodes 1 --machine-type n1-standard-8 \
  --enable-autoscaling --min-nodes=0 --max-nodes=6
  
```

list node pools:  
``` 
gcloud container node-pools list --cluster ${CLUSTER_NAME}
```

describe pool:
