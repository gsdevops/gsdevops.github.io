

### resizing EBS:
* change the size in the UI/CLI for the EBS  
* on the machine run the command:
```bash
lsblk 
# pick your device 
resize2fs ${THE_DEVICE}
# and verify the change applied
# lsblk
```
os some OS versions (ubuntu 14, for example) this may need a reboot.


