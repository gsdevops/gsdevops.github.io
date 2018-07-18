
## Capturing TCP traffic


Installation:  
```shell 
apt-get install -y  tcpdump   tcpslice tcptrace
```

Running:  
```shell 
export TCPDUMP_DUMPS='~/tcptracks/' # or any other location
exprot DUMPED_PORT='8080'
mkdir -p ${TCPDUMP_DUMPS}
cd ${TCPDUMP_DUMPS}
export CURR_TASK=tasks.$$
mkdir ${CURR_TASK}
cd ${CURR_TASK}
tcpdump tcp port ${DUMPED_PORT} -i any -C 100 -z "gzip" -w output.pcap
tcpslice -w full.pcap output.pcap*
mkdir sessions
cd sessions/
tcptrace -e ../full.pcap
```