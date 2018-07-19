# mysql:

Dump (no space beapt-e the password): 

`mysqldump -h HOST -u USER-pPASSWD DB_NAME | gzip -c > SQL_DUMP_NAME`  

Import: 

`mysql -h HOST-u USER-pPASSWD DB_NAME < SQL_DUMP_NAME`    

`MYSQL_PWD='PASSWD'  mysql -h HOST-u USER DB_NAME < SQL_DUMP_NAME`  

 

 

Lowercase tables: lower_case_table_names = 1 in /etc/mysql-server/my.cnf 

 

Add user permissions: 

GRANT ALL PRIVILEGES ON *.* TO 'USER'@'%' IDENTIFIED BY 'PSSWD' WITH GRANT OPTION; 

 

GRANT SELECT ON *.* TO 'user'@'%' IDENTIFIED BY 'password'; 