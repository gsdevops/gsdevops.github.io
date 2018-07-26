

# fix read-only indices :
```
PUT _settings  
{ 
    "index": { 
        "blocks": { 
            "read_only_allow_delete": "false" 
        } 
    } 
} 
```