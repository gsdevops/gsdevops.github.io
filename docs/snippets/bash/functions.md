# Functions
General format and usage
```shell
function myfunc() 
{ 
    local  myresult='some value' 
    echo "$myresult" 
} 
 
result=$(myfunc)   # or result=`myfunc` 
echo $result 
```

All-inclusive runner and status tester
```shell
function run_cmd {
    "$@"
    local cur_stat=$?
    
    if [ "${cur_stat}" -ne 0 ]; then
        echo "ERROR: $@ command was unsuccessful"
    fi
    
    return ${cur_stat}
}
```

Stand-alone status testing function 
```shell
function test_status {
    if [ $1 -ge 1 ]; then
        echo -e "ERROR: the last command was unsuccessful.\n"
        exit 1
    fi
}
```

Test if we're running as root
```shell
function is_root {
    if [ "$EUID" -ne 0 ]; then
        echo -e "\nERROR: run the script as root\n=========="
        exit 1
    fi
}
```
