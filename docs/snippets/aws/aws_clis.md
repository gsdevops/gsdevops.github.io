
#S3 
to copy cross account while passing ownership permissions to the target account:  
use the `--acl` flag.
Example:
```shell
aws s3 cp s3://SOURCE_BUCKETy/KEY_FILE_SRC   s3://DEST_BUCKET_IN_OTHER_ACCOUNT/DEST_KEY_NAME.jar   --acl  bucket-owner-full-control
```

#ECR:


# KMS:
``` shell
awskmsencrypt--region=us-east-1--key-id=d08ce9ae-d0f9-4417-a178-4a2a33923f4a--plaintext"abcdefygrygr"--queryCiphertextBlob--outputtext|base64-D>encbin
``` 

``` shell
awskmsdecrypt--region=us-east-1--ciphertext-blobfileb://encbin--queryPlaintext--outputtext|base64-D 
```

