# Creation
Creating a new user with base (connection and usage) permissions
```sql
CREATE ROLE user_name WITH LOGIN PASSWORD 'password' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';
GRANT CONNECT ON DATABASE db_name TO user_name;
GRANT USAGE ON SCHEMA public TO user_name;
```

# Permission Granting
Granting a user read-only permissions
```sql
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user_name;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO user_name;
```

Granting a user write permissions
```sql
GRANT TRUNCATE ON ALL TABLES IN SCHEMA public TO user_name;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO user_name;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO user_name;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO user_name;
```

Grating a user all permissions
```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO user_name;
```


# Deletion
Deleting a user
```sql
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM user_name;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM user_name;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM user_name;
DROP USER user_name;
```


# Modification
Changing ownership of a DB
```sql
ALTER DATABASE table_name OWNER TO user_name
```

Changing ownership of a DB Table
```sql
ALTER TABLE table_name OWNER TO user_name
```


# Informational Queries
Get DB owner
```sql
SELECT d.datname as "Name",
pg_catalog.pg_get_userbyid(d.datdba) as "Owner"
FROM pg_catalog.pg_database d
WHERE d.datname = 'user_name'
ORDER BY 1;
```

Get DB table owner
```sql
SELECT t.table_name, t.table_type, c.relname, c.relowner, u.usename
FROM information_schema.tables t
JOIN pg_catalog.pg_class c ON (t.table_name = c.relname)
JOIN pg_catalog.pg_user u ON (c.relowner = u.usesysid)
WHERE t.table_schema = 'public';
```

Get user permissions
```sql
SELECT n.nspname as "Schema",
  CASE c.relkind 
    WHEN 'r' THEN 'table' 
    WHEN 'v' THEN 'view' 
    WHEN 'm' THEN 'materialized view' 
    WHEN 'S' THEN 'sequence' 
    WHEN 'f' THEN 'foreign table' 
  END as "Type"
FROM pg_catalog.pg_class c
LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE pg_catalog.array_to_string(c.relacl, E'\n') LIKE '%username%';
```
