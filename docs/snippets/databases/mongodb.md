# Installation
* Manual installation: Follow instructions for relevant Linux distribution from [here](https://docs.mongodb.com/manual/administration/install-on-linux/).
* Automated installation (for Ubuntu 14/16/18 distributions only): Download and run [install_monitoring.sh](scripts/mongodb/install_monitoring.sh) on the 
machine

# Connection to Mongo Shell
```shell
mongo --port 27017 -u root_user -p root_pass --authenticationDatabase admin
```

# Informational Queries
## show DBs, connect to one, and then show collections
```javascript
show dbs
use db_name

show collections
```

## get DB or collection statistics
```javascript
db.stats()

db.collection_name.stats()
```

## get all collection sizes
```javascript
var collectionNames = db.getCollectionNames(), stats = [];
collectionNames.forEach(function (n) { stats.push(db[n].stats()); });
stats = stats.sort(function(a, b) { return b['size'] - a['size']; });
for (var c in stats) { print(stats[c]['ns'] + ": " + stats[c]['size'] + " (" + stats[c]['storageSize'] + ")"); } 
```

# Configuration


# Adding shard

#Cheat sheet
 cheat.sh/mongo  
 
* who is master and who replica
* status
* disk usage
* restarting
* synchronization
   