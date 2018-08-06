

#ECR:


# KMS:
``` shell
awskmsencrypt--region=us-east-1--key-id=d08ce9ae-d0f9-4417-a178-4a2a33923f4a--plaintext"abcdefygrygr"--queryCiphertextBlob--outputtext|base64-D>encbin
``` 

``` shell
awskmsdecrypt--region=us-east-1--ciphertext-blobfileb://encbin--queryPlaintext--outputtext|base64-D 
```


