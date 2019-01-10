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

##  CloudTrail logs

```
CREATE EXTERNAL TABLE [TABLE_NAME] (
    eventVersion STRING,
    userIdentity STRUCT<
        type: STRING,
        principalId: STRING,
        arn: STRING,
        accountId: STRING,
        invokedBy: STRING,
        accessKeyId: STRING,
        userName: STRING,
        sessionContext: STRUCT<
            attributes: STRUCT<
                mfaAuthenticated: STRING,
                creationDate: STRING>,
            sessionIssuer: STRUCT<
                type: STRING,
                principalId: STRING,
                arn: STRING,
                accountId: STRING,
                userName: STRING>>>,
    eventTime STRING,
    eventSource STRING,
    eventName STRING,
    awsRegion STRING,
    sourceIpAddress STRING,
    userAgent STRING,
    errorCode STRING,
    errorMessage STRING,
    requestParameters STRING,
    responseElements STRING,
    additionalEventData STRING,
    requestId STRING,
    eventId STRING,
    resources ARRAY<STRUCT<
        arn: STRING,
        accountId: STRING,
        type: STRING>>,
    eventType STRING,
    apiVersion STRING,
    readOnly STRING,
    recipientAccountId STRING,
    serviceEventDetails STRING,
    sharedEventID STRING,
    vpcEndpointId STRING
)
COMMENT 'CloudTrail table for [S3_BUCKET_NAME] bucket'
ROW FORMAT SERDE 'com.amazon.emr.hive.serde.CloudTrailSerde'
STORED AS INPUTFORMAT 'com.amazon.emr.cloudtrail.CloudTrailInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://[S3_BUCKET_URL]'
TBLPROPERTIES ('classification'='cloudtrail');
```


### for the jdbc connection use this jdbc url:

`jdbc:awsathena://athena.THE_ATHENA_REGION.amazonaws.com:443/`  

* more detailed instructions:  
 [https://medium.com/datamindedbe/connect-to-aws-athena-using-datagrip-c34762e37a17](https://medium.com/datamindedbe/connect-to-aws-athena-using-datagrip-c34762e37a17) - workstation setup  



# Querying the data:  

### for the jdbc connection use this jdbc url:

`jdbc:awsathena://athena.THE_ATHENA_REGION.amazonaws.com:443/`  

* more detailed instructions:  
 [https://medium.com/datamindedbe/connect-to-aws-athena-using-datagrip-c34762e37a17](https://medium.com/datamindedbe/connect-to-aws-athena-using-datagrip-c34762e37a17) - workstation setup  


### Parsing timestamps:
 *  **the format is CASE SENSIITVE**      
`parse_datetime(request_timestamp, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z''')` 

* Query to calculate AVG/CNT grouped daily by verb and ret code:  
```
select   date(parse_datetime(request_timestamp, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z''')) as req_date,  request_verb, elb_response_code, avg(backend_processing_time) as avg_dur, count(*) as cnt  from elb_logs_2 where parse_datetime(request_timestamp, 'YYYY-MM-dd''T''HH:mm:ss.SSSSSS''Z''') >  date (now() - interval '6' day) group by  date(parse_datetime(request_timestamp, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z''')), request_verb , elb_response_code;
```

```
select  request_verb,  date(parse_datetime(request_timestamp, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z''')) as req_date,  avg(backend_processing_time) as avg_dur, count(*) as cnt  from elb_logs_2 where parse_datetime(request_timestamp, 'YYYY-MM-dd''T''HH:mm:ss.SSSSSS''Z''') >  parse_datetime('2018-01-20T09:00:07.490349Z', 'YYYY-MM-dd''T''HH:mm:ss.SSSSSS''Z''') group by date(parse_datetime(request_timestamp, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z''')) ;
```


### Listing buckets in use:
```bash
aws glue get-tables --database-name DB_NAME --region us-west-2 --query 'TableList[*].{Name:Name, Location:StorageDescriptor.Location}' --output text
```

