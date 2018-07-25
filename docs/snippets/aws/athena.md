# How to query

# Setup



# Read ELB logs using athena
```sql
CREATE EXTERNAL TABLE IF NOT EXISTS elb_logs (
 request_timestamp string,
 elb_name string,
 request_ip string,
 request_port int,
 backend_ip string,
 backend_port int,
 request_processing_time double,
 backend_processing_time double,
 client_response_time double,
 elb_response_code string,
 backend_response_code string,
 received_bytes bigint,
 sent_bytes bigint,
 request_verb string,
 url string,
 protocol string,
 user_agent string,
 ssl_cipher string,
 ssl_protocol string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
 'serialization.format' = '1',
 'input.regex' = '([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*)[:\-]([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-.0-9]*) (|[-0-9]*) (-|[-0-9]*) ([-0-9]*) ([-0-9]*) \\\"([^ ]*) ([^ ]*) (- |[^ ]*)\\\" (\"[^\"]*\") ([A-Z0-9-]+) ([A-Za-z0-9.-]*)$' )
LOCATION 's3://your_log_bucket/prefix/AWSLogs/AWS_account_ID/elasticloadbalancing/';
```

### for the jdbc connection use this jdbc url:

`jdbc:awsathena://athena.THE_ATHENA_REGION.amazonaws.com:443/`  

* more detailed instructions:  
 [https://medium.com/datamindedbe/connect-to-aws-athena-using-datagrip-c34762e37a17](https://medium.com/datamindedbe/connect-to-aws-athena-using-datagrip-c34762e37a17) - workstation setup  


