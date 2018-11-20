
# Redis snippets: 


### Config settings:
set the vm over commit:
```bash
# get the current value
sysctl vm.overcommit_memory

```

### redis-cli (cli tool):
```bash
redis-cli [-h NAME/IP_OF_HOST]
# - OR - 
redis-cli # connecting to localhost
```
can also pass commands directly:  
```bash
# general info
redis-cli info
# get the config value (slaveof)
redis-cli config get  slaveof
redis-cli config get  slav*
# set the value
redis-cli slaveof HOST PORT

```

```bash
client-output-buffer-limit "normal 0 0 0 slave 536870912 67108864 60 pubsub 33554432 8388608 60"
```
