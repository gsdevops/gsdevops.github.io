# AWS - contents 

* [athena](./athena.md)
* [boto3 items](./boto3_items.md)
* [awscli](./aws_clis.md)

  
  
  
# AWS quickies:  

From any ec2 instance, you can run these to get info of the machine:
```shell 
curl http://169.254.169.254/latest/meta-data/instance-id  
curl http://169.254.169.254/latest/meta-data/ami-id    
curl http://169.254.169.254/latest/meta-data/security-groups
```

etc...