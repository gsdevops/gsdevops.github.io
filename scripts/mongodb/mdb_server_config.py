# All MongoDB Hosts
hosts = {
    "stg": {
        "cfg": [
            {"host": "mongo-cfg-rs01-01-stg.example.com", "port": "27017", "ip": "172.16.12.150"},
        ],
        "rs": [
            {"host": "mongo-db-rs01-01-stg.example-int.com", "port": "27017", "ip": "172.16.12.66"},
            {"host": "mongo-db-rs01-02-stg.example-int.com", "port": "27017", "ip": "172.16.12.171"}
        ]
    }
}
