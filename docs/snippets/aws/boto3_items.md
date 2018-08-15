

# Region selection
```python
import boto3
region='us-east-1'
ssn = boto3.session.Session(region_name=region)
```


# Switch role/user (sts):
In order to switch roles,

```python
import boto3
region = 'bla...'
ssn = boto3.session.Session(region_name=region)
sts_conn = ssn.client('sts')

creds = sts_conn.assume_role(RoleArn='arn:aws:iam::XX:role/THE_ROLE', RoleSessionName='JUST_A_NAME')['Credentials']

acc_key_id = creds['AccessKeyId']
sec_key_id = creds['SecretAccessKey']
ssn_token = creds['SessionToken']

other_session = boto3.session.Session(region_name=region,
                                 aws_access_key_id=acc_key_id,
                                 aws_secret_access_key=sec_key_id,
                                 aws_session_token=ssn_token
                                 )

``` 


# Zappa.io  

[zappa configuration](https://github.com/Miserlou/Zappa#advanced-settings)