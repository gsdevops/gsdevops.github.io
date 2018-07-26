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

select  request_verb,  date(parse_datetime(request_timestamp, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z''')) as req_date,  avg(backend_processing_time) as avg_dur, count(*) as cnt  from elb_logs_2 where parse_datetime(request_timestamp, 'YYYY-MM-dd''T''HH:mm:ss.SSSSSS''Z''') >  parse_datetime('2018-01-20T09:00:07.490349Z', 'YYYY-MM-dd''T''HH:mm:ss.SSSSSS''Z''') group by date(parse_datetime(request_timestamp, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z''')) ;

limit 10;
