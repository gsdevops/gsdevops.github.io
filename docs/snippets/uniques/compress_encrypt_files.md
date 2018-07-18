Create splitted encrypted file 

Used to take a file, encrypt and break to small frags so it is easier to pass under low latency network  

Create the splits: 
``` shell 
gzip -c ORIGINAL_FILE > ORIGINAL_FILE.gz  #optional 

openssl des3 -salt -in ORIGINAL_FILE.gz -out ORIGINAL_FILE.gz.des3 -kfile ./PWD_FILE 

split -b 10000000 ORIGINAL_FILE.gz.des3 ORIGINAL_SPLIT_PREFIX_ 
```

 

Merge splitted: 
``` shell 
mkdir -p extemp 

cp ORIGINAL_SPLIT_PREFIX_* extemp/ 

cd extemp 

cat ORIGINAL_SPLIT_PREFIX_* > TARGET_FILE.gz.des3 

openssl des3 -d -salt -in TARGET_FILE.gz.des3 -out TARGET_FILE.gz 

gunzip TARGET_FILE.gz 
```
