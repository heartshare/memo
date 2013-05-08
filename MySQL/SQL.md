### TODO

CHANGE MASTER TO

## USER

#### GRANT ALL PRIVILEGES ON database.table TO 'account'@'host' IDENTIFIED BY 'password' (WITH GRANT OPTION) ;

GRANTでアカウントを作成した場合は、`FLUSH PRIVILEGES`は不要。  
  
```
mysql>
mysql> SELECT host,user FROM mysql.user;
+-----------------+---------------+
| host            | user          |
+-----------------+---------------+
| 127.0.0.1       | root          |
| ::1             | root          |
| localhost       |               |
| localhost       | root          |
+-----------------+---------------+
4 rows in set (0.02 sec)

mysql>
```

#### GRANT * ON *.* TO 'account'@'host' IDENTIFIED BY 'password';

```
mysql>
mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON *.* TO 'hage'@'localhost' IDENTIFIED BY 'obscure';
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> SELECT User,Host,Password FROM mysql.user WHERE User = 'hage';
+------+-----------+-------------------------------------------+
| User | Host      | Password                                  |
+------+-----------+-------------------------------------------+
| hage | localhost | *09E4D4C2617F3CB4CA5549F0E9C8D5B3B02DF720 |
+------+-----------+-------------------------------------------+
1 row in set (0.00 sec)

mysql>
```

#### INSERT INTO user (Host,User,Password) VALUES('localhost','custom',PASSWORD('obscure'));

```
mysql>
mysql> use mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql>
mysql> INSERT INTO user (Host,User,Password) VALUES('localhost','custom',PASSWORD('obscure'));
Query OK, 1 row affected, 3 warnings (0.01 sec)

mysql> SELECT User,Host,Password FROM user WHERE User = 'custom';
+--------+-----------+-------------------------------------------+
| User   | Host      | Password                                  |
+--------+-----------+-------------------------------------------+
| custom | localhost | *09E4D4C2617F3CB4CA5549F0E9C8D5B3B02DF720 |
+--------+-----------+-------------------------------------------+
1 row in set (0.00 sec)

mysql>
mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.00 sec)

mysql>
```

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON *.* TO 'custom'@'localhost' IDENTIFIED BY 'obscure';



#### WITH GRANT OPTION

```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'monty'@'localhost' IDENTIFIED BY 'some_pass' WITH GRANT OPTION;
Query OK, 0 rows affected (0.01 sec)

mysql>

% mysql -umonty -psome_pass                                                                                                                                                                                    [master ~/dev/memo/MySQL]
Warning: Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.6.10-log Source distribution

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
mysql> GRANT ALL PRIVILEGES ON *.* TO 'monty2'@'localhost' IDENTIFIED BY 'some_pass';
Query OK, 0 rows affected (0.00 sec)

mysql>



% mysql -umonty2 -psome_pass                                                                                                                                                                                   [master ~/dev/memo/MySQL]
Warning: Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.6.10-log Source distribution

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>


% mysql -umonty2 -psome_pass                                                                                                                                                                                   [master ~/dev/memo/MySQL]
Warning: Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.6.10-log Source distribution

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
mysql>
mysql> GRANT ALL PRIVILEGES ON *.* TO 'monty3'@'localhost' IDENTIFIED BY 'some_pass';
ERROR 1045 (28000): Access denied for user 'monty2'@'localhost' (using password: YES)
mysql>
```

#### SET PASSWORD

```
mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON *.* TO 'hage'@'localhost' IDENTIFIED BY 'obscure';
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> SELECT User,Host,Password FROM mysql.user WHERE User = 'hage';
+------+-----------+-------------------------------------------+
| User | Host      | Password                                  |
+------+-----------+-------------------------------------------+
| hage | localhost | *09E4D4C2617F3CB4CA5549F0E9C8D5B3B02DF720 |
+------+-----------+-------------------------------------------+
1 row in set (0.00 sec)

mysql>
mysql> SET PASSWORD 'hage'@'localhost' = password('hageteru');
Query OK, 0 rows affected (0.00 sec)

mysql>


% mysql -uhage -phageteru                                                                                                                                                                                      [master ~/dev/memo/MySQL]
Warning: Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 5
Server version: 5.6.10-log Source distribution

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

```
mysql>
mysql> SET PASSWORD = PASSWORD('hagetenai');
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> ^DBye
['-']% mysql -uhage -phagetenai                                                                                                                                                                                     [master ~/dev/memo/MySQL]
Warning: Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 7
Server version: 5.6.10-log Source distribution

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

#### DROP USER

```
mysql>
mysql> SELECT User,Host,Password FROM mysql.user WHERE User = 'hage';
+------+-----------+-------------------------------------------+
| User | Host      | Password                                  |
+------+-----------+-------------------------------------------+
| hage | localhost | *09E4D4C2617F3CB4CA5549F0E9C8D5B3B02DF720 |
+------+-----------+-------------------------------------------+
1 row in set (0.00 sec)

mysql>
mysql> DROP USER 'hage'@'localhost';
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> SELECT User,Host,Password FROM mysql.user WHERE User = 'hage';
Empty set (0.00 sec)

mysql>
```



## COLUMN

### SELECT

#### `SELECT column FROM table;`

```
mysql>
mysql> SELECT * FROM homhom;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   1000 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
| akemi    |   1000 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
| akemi    |   1000 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
| akemi    |   1000 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
| akemi    |    998 | 2010-12-31 01:00:00 |
| homura   |    999 | 2010-11-11 00:00:00 |
| homuhomu |   1003 | 1999-12-31 00:00:00 |
| homu     |   1001 | 1990-12-31 02:00:00 |
+----------+--------+---------------------+
20 rows in set (0.01 sec)

mysql>
mysql> SELECT * FROM homhom LIMIT 5;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   1000 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
| akemi    |   1000 | 1999-12-31 01:00:00 |
+----------+--------+---------------------+
5 rows in set (0.00 sec)

mysql>
mysql> SELECT name,number FROM homhom LIMIT 5;
+----------+--------+
| name     | number |
+----------+--------+
| akemi    |   1000 |
| homura   |   1000 |
| homuhomu |   1000 |
| homu     |   1001 |
| akemi    |   1000 |
+----------+--------+
5 rows in set (0.00 sec)

mysql>
```

### LIKE

```
mysql> SELECT name FROM homhom WHERE name LIKE '%hom%';
+----------+
| name     |
+----------+
| homura   |
| homuhomu |
| homu     |
| homura   |
| homuhomu |
| homu     |
| homura   |
| homuhomu |
+----------+
8 rows in set (0.01 sec)

mysql>
mysql> SELECT name FROM homhom WHERE name NOT LIKE '%hom%';
+-------+
| name  |
+-------+
| akemi |
| akemi |
| akemi |
+-------+
3 rows in set (0.00 sec)

mysql>
```

### ORDER BY

#### `SELECT column FROM table ORDER BY column;`

##### ASC (Default)

```
mysql>
mysql> SELECT name, number FROM homhom ORDER BY number;
+----------+--------+
| name     | number |
+----------+--------+
| akemi    |    998 |
| homura   |    999 |
| akemi    |   1000 |
| homuhomu |   1000 |
| homura   |   1000 |
| akemi    |   1000 |
| homuhomu |   1000 |
| homura   |   1000 |
| akemi    |   1000 |
| homuhomu |   1000 |
| homura   |   1000 |
| homura   |   1000 |
| akemi    |   1000 |
| homuhomu |   1000 |
| homu     |   1001 |
| homu     |   1001 |
| homu     |   1001 |
| homu     |   1001 |
| homu     |   1001 |
| homuhomu |   1003 |
+----------+--------+
20 rows in set (0.00 sec)

mysql>
```

##### DESC

```
mysql>
mysql> SELECT name, number FROM homhom ORDER BY number DESC;
+----------+--------+
| name     | number |
+----------+--------+
| homuhomu |   1003 |
| homu     |   1001 |
| homu     |   1001 |
| homu     |   1001 |
| homu     |   1001 |
| homu     |   1001 |
| akemi    |   1000 |
| homura   |   1000 |
| homuhomu |   1000 |
| homuhomu |   1000 |
| homura   |   1000 |
| homura   |   1000 |
| homuhomu |   1000 |
| akemi    |   1000 |
| homura   |   1000 |
| homuhomu |   1000 |
| akemi    |   1000 |
| akemi    |   1000 |
| homura   |    999 |
| akemi    |    998 |
+----------+--------+
20 rows in set (0.00 sec)

mysql>
mysql>
```

### SELECT MAX

#### `SELECT MAX(column) FROM table;`

```
mysql>
mysql> SELECT MAX(number) FROM homhom;
+-------------+
| MAX(number) |
+-------------+
|        1002 |
+-------------+
1 row in set (0.00 sec)

mysql>
mysql>
mysql> SELECT name FROM homhom WHERE number = (SELECT MAX(number) FROM homhom);
+-------+
| name  |
+-------+
| akemi |
+-------+
1 row in set (0.00 sec)

mysql>
```

```
mysql>
mysql> SELECT name FROM homhom WHERE number = (SELECT number FROM homhom WHERE number = '1000');
ERROR 1242 (21000): Subquery returns more than 1 row
mysql>
mysql> SELECT number FROM homhom WHERE number = '1000';
+--------+
| number |
+--------+
|   1000 |
|   1000 |
+--------+
2 rows in set (0.01 sec)

mysql>
mysql> SELECT name FROM homhom WHERE number = (SELECT number FROM homhom WHERE number = '1000' GROUP BY number);
+----------+
| name     |
+----------+
| homura   |
| homuhomu |
+----------+
2 rows in set (0.00 sec)

mysql>
```

### SELECT AVERAGE

#### `SELECT AVG(column) FROM table;`

```
mysql>
mysql> SELECT AVG(number) FROM homhom;
+-------------+
| AVG(number) |
+-------------+
|   1000.2500 |
+-------------+
1 row in set (0.01 sec)

mysql>`
```


### SELECT WHERE IN


#### `SELECT column FROM table WHERE column IN (date,date)`

```
mysql>
mysql> SELECT * FROM homhom;
+----+----------+--------+---------------------+
| id | name     | number | date                |
+----+----------+--------+---------------------+
|  1 | akemi    |    998 | 2010-12-31 01:00:00 |
|  2 | homura   |    999 | 1999-12-31 01:00:00 |
|  3 | homuhomu |   1003 | 1970-12-31 02:00:00 |
|  4 | homu     |   1001 | 1990-12-31 02:00:00 |
+----+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM homhom WHERE name IN ('akemi','homu') ;
+----+-------+--------+---------------------+
| id | name  | number | date                |
+----+-------+--------+---------------------+
|  1 | akemi |    998 | 2010-12-31 01:00:00 |
|  4 | homu  |   1001 | 1990-12-31 02:00:00 |
+----+-------+--------+---------------------+
2 rows in set (0.00 sec)

mysql>
mysql> SELECT * FROM homhom WHERE name IN (SELECT name FROM homhom WHERE date > '1998-01-01');
+----+--------+--------+---------------------+
| id | name   | number | date                |
+----+--------+--------+---------------------+
|  1 | akemi  |    998 | 2010-12-31 01:00:00 |
|  2 | homura |    999 | 1999-12-31 01:00:00 |
+----+--------+--------+---------------------+
2 rows in set (0.00 sec)

mysql>
```

### HAVING

#### `SELECT column FROM table GROUP BY column HAVING column = date `

`GROUP BY`された後のデータに対してフィルタをかける

```
mysql>
mysql> SELECT * FROM homhom;
+----+----------+--------+---------------------+
| id | name     | number | date                |
+----+----------+--------+---------------------+
|  1 | akemi    |    998 | 2010-12-31 01:00:00 |
|  2 | homura   |    999 | 1999-12-31 01:00:00 |
|  3 | homuhomu |   1003 | 1970-12-31 02:00:00 |
|  4 | homu     |   1001 | 1990-12-31 02:00:00 |
|  5 | akemi    |    998 | 2010-12-31 01:00:00 |
|  6 | homura   |    999 | 1999-12-31 01:00:00 |
|  7 | homuhomu |   1003 | 1970-12-31 02:00:00 |
|  8 | homu     |   1001 | 1990-12-31 02:00:00 |
|  9 | akemi    |    998 | 2010-12-31 01:00:00 |
| 10 | homura   |    999 | 1999-12-31 01:00:00 |
| 11 | homuhomu |   1003 | 1970-12-31 02:00:00 |
+----+----------+--------+---------------------+
11 rows in set (0.01 sec)

mysql>
mysql>
mysql> SELECT * FROM homhom GROUP BY number;
+----+----------+--------+---------------------+
| id | name     | number | date                |
+----+----------+--------+---------------------+
|  1 | akemi    |    998 | 2010-12-31 01:00:00 |
|  2 | homura   |    999 | 1999-12-31 01:00:00 |
|  4 | homu     |   1001 | 1990-12-31 02:00:00 |
|  3 | homuhomu |   1003 | 1970-12-31 02:00:00 |
+----+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql> SELECT name, COUNT(number) AS num FROM homhom GROUP BY number;
+----------+-----+
| name     | num |
+----------+-----+
| akemi    |   3 |
| homura   |   3 |
| homu     |   2 |
| homuhomu |   3 |
+----------+-----+
4 rows in set (0.10 sec)

mysql>
mysql> SELECT name, COUNT(number) AS num FROM homhom GROUP BY number HAVING num > 2;
+----------+-----+
| name     | num |
+----------+-----+
| akemi    |   3 |
| homura   |   3 |
| homuhomu |   3 |
+----------+-----+
3 rows in set (0.00 sec)

mysql> SELECT name, COUNT(number) AS num FROM homhom GROUP BY number HAVING num < 3;
+------+-----+
| name | num |
+------+-----+
| homu |   2 |
+------+-----+
1 row in set (0.10 sec)

mysql>
```

### UNION

```
mysql>
mysql> ysql> (* FROM homhom;
+----+----------+--------+---------------------+
| id | name     | number | date                |
+----+----------+--------+---------------------+
|  1 | akemi    |    998 | 2010-12-31 01:00:00 |
|  2 | homura   |    999 | 1999-12-31 01:00:00 |
|  3 | homuhomu |   1003 | 1970-12-31 02:00:00 |
|  4 | homu     |   1001 | 1990-12-31 02:00:00 |
|  5 | akemi    |    998 | 2010-12-31 01:00:00 |
|  6 | homura   |    999 | 1999-12-31 01:00:00 |
|  7 | homuhomu |   1003 | 1970-12-31 02:00:00 |
|  8 | homu     |   1001 | 1990-12-31 02:00:00 |
|  9 | akemi    |    998 | 2010-12-31 01:00:00 |
| 10 | homura   |    999 | 1999-12-31 01:00:00 |
| 11 | homuhomu |   1003 | 1970-12-31 02:00:00 |
+----+----------+--------+---------------------+
11 rows in set (0.00 sec)

mysql>
mysql> (SELECT id FROM homhom) UNION (SELECT number FROM homhom);
+------+
| id   |
+------+
|    1 |
|    2 |
|    3 |
|    4 |
|    5 |
|    6 |
|    7 |
|    8 |
|    9 |
|   10 |
|   11 |
|  998 |
|  999 |
| 1003 |
| 1001 |
+------+
15 rows in set (0.00 sec)

mysql> (SELECT id FROM homhom) UNION ALL (SELECT number FROM homhom);
+------+
| id   |
+------+
|    1 |
|    2 |
|    3 |
|    4 |
|    5 |
|    6 |
|    7 |
|    8 |
|    9 |
|   10 |
|   11 |
|  998 |
|  999 |
| 1003 |
| 1001 |
|  998 |
|  999 |
| 1003 |
| 1001 |
|  998 |
|  999 |
| 1003 |
+------+
22 rows in set (0.01 sec)

mysql>
```


### INSERT INTO

#### `INSERT INTO table (column) VALUE ('data');`

```
mysql> INSERT INTO homhom (name, number, date) VALUE ('akemi', '1000', '1999-12-31 01:00:00');
Query OK, 1 row affected (0.00 sec)
mysql>
mysql> SELECT * FROM homhom;
+-------+--------+---------------------+
| name  | number | date                |
+-------+--------+---------------------+
| akemi |   1000 | 1999-12-31 01:00:00 |
+-------+--------+---------------------+
1 row in set (0.00 sec)

mysql>
mysql> INSERT INTO homhom (name, number, date) VALUE ('homura', '1000', '1999-12-31 01:00:00');
Query OK, 1 row affected (0.00 sec)

mysql>
mysql> SELECT * FROM homhom;
+--------+--------+---------------------+
| name   | number | date                |
+--------+--------+---------------------+
| akemi  |   1000 | 1999-12-31 01:00:00 |
| homura |   1000 | 1999-12-31 01:00:00 |
+--------+--------+---------------------+
2 rows in set (0.00 sec)

mysql>
mysql> INSERT INTO homhom (name, number, date) VALUE ('homuhomu', '1000', '1999-12-31 02:00:00');
Query OK, 1 row affected (0.00 sec)

mysql>
mysql> INSERT INTO homhom (name, number, date) VALUE ('homu', '1001', '1999-12-31 02:00:00');
Query OK, 1 row affected (0.01 sec)

mysql>
mysql> SELECT * FROM homhom;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   1000 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
```

#### BULK INSERT

`INSERT INTO table (column_one, column_two) VALUE ('data_one','data_two'),('data_one','data_two')...;`


### UPDATE

#### `UPDATE table SET column = 'data' WHERE column = hoge;`

```
mysql>
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> UPDATE homhom SET number = '9999';
Query OK, 4 rows affected (0.10 sec)
Rows matched: 4  Changed: 4  Warnings: 0

mysql>
mysql> SELECT * FROM homhom;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   9999 | 1999-12-31 01:00:00 |
| homura   |   9999 | 1999-12-31 01:00:00 |
| homuhomu |   9999 | 1999-12-31 02:00:00 |
| homu     |   9999 | 1999-12-31 02:00:00 |
+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> SELECT * FROM homhom;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   1000 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> UPDATE homhom SET number = '9999' WHERE name = 'akemi';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> SELECT * FROM homhom;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   9999 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> SELECT * FROM homhom;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   9999 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1001 | 1999-12-31 02:00:00 |
+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
```

### DELETE

`DELETE FROM table WHERE column = hoge;`

```
mysql>
mysql> SELECT * FROM homhom;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   1001 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1002 | 1999-12-31 02:00:00 |
+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
mysql> START TRANSACTION;                                                                                                                                                                                                                     Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> DELETE FROM homhom;
Query OK, 4 rows affected (0.00 sec)

mysql>
mysql> SELECT * FROM homhom;
Empty set (0.00 sec)

mysql>
mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> SELECT * FROM homhom;
+----------+--------+---------------------+
| name     | number | date                |
+----------+--------+---------------------+
| akemi    |   1001 | 1999-12-31 01:00:00 |
| homura   |   1000 | 1999-12-31 01:00:00 |
| homuhomu |   1000 | 1999-12-31 02:00:00 |
| homu     |   1002 | 1999-12-31 02:00:00 |
+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
mysql> START TRANSACTION;                                                                                                                                                                                                                     Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> DELETE FROM homhom WHERE number = '1000';
Query OK, 2 rows affected (0.00 sec)

mysql>
mysql> SELECT * FROM homhom;
+-------+--------+---------------------+
| name  | number | date                |
+-------+--------+---------------------+
| akemi |   1001 | 1999-12-31 01:00:00 |
| homu  |   1002 | 1999-12-31 02:00:00 |
+-------+--------+---------------------+
2 rows in set (0.00 sec)

mysql>
mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql>
mysql> SELECT * FROM homhom;
+-------+--------+---------------------+
| name  | number | date                |
+-------+--------+---------------------+
| akemi |   1001 | 1999-12-31 01:00:00 |
| homu  |   1002 | 1999-12-31 02:00:00 |
+-------+--------+---------------------+
2 rows in set (0.00 sec)

mysql>
```

##### DROPはCOUNTが進む

```
mysql>
mysql> DELETE FROM homhom WHERE number = '1000';
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql>
mysql> INSERT INTO homhom (name, number, date) VALUE ('akemi', '998', '2010-12-31 01:00:00');
Query OK, 1 row affected (0.10 sec)

mysql>
mysql> SELECT * FROM homhom;
+----+----------+--------+---------------------+
| id | name     | number | date                |
+----+----------+--------+---------------------+
|  1 | akemi    |    998 | 2010-12-31 01:00:00 |
|  2 | homura   |    999 | 1999-12-31 01:00:00 |
|  3 | homuhomu |   1003 | 1970-12-31 02:00:00 |
|  4 | homu     |   1001 | 1990-12-31 02:00:00 |
|  5 | akemi    |    998 | 2010-12-31 01:00:00 |
+----+----------+--------+---------------------+
5 rows in set (0.00 sec)

mysql>
mysql>
mysql> DELETE FROM homhom;
Query OK, 5 rows affected (0.00 sec)

mysql>
mysql> INSERT INTO homhom (name, number, date) VALUE ('akemi', '998', '2010-12-31 01:00:00');
Query OK, 1 row affected (0.01 sec)

mysql>
mysql>
mysql> SELECT * FROM homhom;
+----+-------+--------+---------------------+
| id | name  | number | date                |
+----+-------+--------+---------------------+
|  6 | akemi |    998 | 2010-12-31 01:00:00 |
+----+-------+--------+---------------------+
1 row in set (0.00 sec)

mysql>
```

### TRANCATE

- ROLLBACKができない
- AUTO_INCREMENTのカウントはゼロになる
- 動作はDROP=>CREATE

```
mysql>
mysql> SELECT * FROM homhom;
+----+----------+--------+---------------------+
| id | name     | number | date                |
+----+----------+--------+---------------------+
|  1 | akemi    |    998 | 2010-12-31 01:00:00 |
|  2 | homura   |    999 | 0000-00-00 00:00:00 |
|  3 | homuhomu |   1003 | 0000-00-00 00:00:00 |
|  4 | homu     |   1001 | 1990-12-31 02:00:00 |
+----+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
mysql> TRUNCATE TABLE homhom;
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> SELECT * FROM homhom;
Empty set (0.00 sec)

mysql>
mysql>
mysql> INSERT INTO homhom (name, number, date) VALUE ('akemi', '998', '2010-12-31 01:00:00'),('homura', '999', '1999-12-31 01:00:00'),('homuhomu', '1003', '1970-12-31 02:00:00'),('homu', '1001', '1990-12-31 02:00:00');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql>
mysql> SELECT * FROM homhom;
+----+----------+--------+---------------------+
| id | name     | number | date                |
+----+----------+--------+---------------------+
|  1 | akemi    |    998 | 2010-12-31 01:00:00 |
|  2 | homura   |    999 | 1999-12-31 01:00:00 |
|  3 | homuhomu |   1003 | 1970-12-31 02:00:00 |
|  4 | homu     |   1001 | 1990-12-31 02:00:00 |
+----+----------+--------+---------------------+
4 rows in set (0.00 sec)

mysql>
mysql>
```



## JOIN

### SAMPLE RECORD

```
mysql>
mysql> SELECT * FROM parent WHERE id >= 200;
+-----+--------+------------------+---------------------+
| id  | number | name             | timestamp           |
+-----+--------+------------------+---------------------+
| 200 |    200 | Erasmus Phillips | 2012-04-20 11:46:55 |
| 210 |   NULL | tes tes          | 0000-00-00 00:00:00 |
+-----+--------+------------------+---------------------+
2 rows in set (0.00 sec)

mysql>
mysql> SELECT * FROM child WHERE id >= 200;
+-----+---------------+-----------+---------------------+
| id  | parent_number | nickname  | timestamp           |
+-----+---------------+-----------+---------------------+
| 200 |           200 | Pickett   | 2011-02-06 12:04:38 |
| 211 |          NULL | test test | 0000-00-00 00:00:00 |
+-----+---------------+-----------+---------------------+
2 rows in set (0.00 sec)

mysql>
```

### INNER JOIN

英語で書こうと思ったけどきびしくなってきた。  
`INNER JOIN`は左右両方ともデータがある場合に表示

```
mysql>
mysql> SELECT parent.id AS p_id, child.id AS c_id, parent.name, child.nickname FROM parent INNER JOIN child ON parent.id = child.id WHERE parent.id IN ('200', '210', '211');
+------+------+------------------+----------+
| p_id | c_id | name             | nickname |
+------+------+------------------+----------+
|  200 |  200 | Erasmus Phillips | Pickett  |
+------+------+------------------+----------+
1 row in set (0.00 sec)

mysql>
```

### LEFT JOIN

`LEFT JOIN`は左側にあるヤツは無条件で出して  
対応する右側は対応するデータがなければ表示しない

```
mysql>
mysql> SELECT parent.id AS p_id, child.id AS c_id, parent.name, child.nickname FROM parent LEFT JOIN child ON parent.id = child.id WHERE parent.id IN ('200', '210', '211');
+------+------+------------------+----------+
| p_id | c_id | name             | nickname |
+------+------+------------------+----------+
|  200 |  200 | Erasmus Phillips | Pickett  |
|  210 | NULL | tes tes          | NULL     |
+------+------+------------------+----------+
2 rows in set (0.00 sec)

mysql>
```

### RIGHT JOIN

LEFTの逆。あんまり使わないらしい

```
mysql> SELECT parent.id AS p_id, child.id AS c_id, parent.name, child.nickname FROM parent RIGHT JOIN child ON parent.id = child.id WHERE parent.id IN ('200', '210', '211');
+------+------+------------------+-----------+
| p_id | c_id | name             | nickname  |
+------+------+------------------+-----------+
|  200 |  200 | Erasmus Phillips | Pickett   |
| NULL |  211 | NULL             | test test |
+------+------+------------------+-----------+
2 rows in set (0.00 sec)

mysql>
```

## DATABASE

#### `CREATE DATABASE database DEFAULT CHARSET utf8`

```
mysql>
mysql> CREATE DATABASE homho DEFAULT CHARACTER SET utf8;
Query OK, 1 row affected (0.00 sec)

mysql>
mysql>
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| homhom             |
| mysql              |
| performance_schema |
| test               |
+--------------------+
5 rows in set (0.00 sec)

mysql>
mysql> SHOW CREATE DATABASE homho;
+----------+-----------------------------------------------------------------+
| Database | Create Database                                                 |
+----------+-----------------------------------------------------------------+
| homhom   | CREATE DATABASE `homhom` /*!40100 DEFAULT CHARACTER SET utf8 */ |
+----------+-----------------------------------------------------------------+
1 row in set (0.00 sec)

mysql>
```

#### `CREATE DATABASE database DEFAULT CHARACTER SET utf8mb4;`

```
mysql>
mysql> CREATE DATABASE homhom_emoticon DEFAULT CHARACTER SET utf8mb4;
Query OK, 1 row affected (0.01 sec)

mysql>
mysql>
mysql> SHOW CREATE DATABASE homhom_emoticon;
+-----------------+-----------------------------------------------------------------------------+
| Database        | Create Database                                                             |
+-----------------+-----------------------------------------------------------------------------+
| homhom_emoticon | CREATE DATABASE `homhom_emoticon` /*!40100 DEFAULT CHARACTER SET utf8mb4 */ |
+-----------------+-----------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql>
```

4バイトUTF8の場合、InnoDBでは767バイトまでの長さのインデックスしかサポートしないので  
767÷4=191文字となる点に注意。`text VARCHAR(191)`  

参考: [MySQL 5.5新機能徹底解説 / 漢のコンピュータ道](http://nippondanji.blogspot.jp/2010/12/mysql-55.html)

## TABLE

### CREATE COLUMN

#### `CREATE TABLE table column type;`  

- create `name` column

```
mysql>
mysql> CREATE TABLE hoge ( name VARCHAR(255) );
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql> DESC hoge;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| name  | varchar(255) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
1 row in set (0.01 sec)

mysql>
```

### COLUMN ADD

#### `ALTER TABLE table ADD column type;`

- add `last_name` column

```
mysql>
mysql> DESC hoge;
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| first_name | varchar(255) | NO   |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
1 row in set (0.00 sec)

mysql>
mysql> ALTER TABLE hoge ADD last_name VARCHAR(255) NOT NULL;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql> DESC hoge;
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| first_name | varchar(255) | NO   |     | NULL    |       |
| last_name  | varchar(255) | NO   |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

mysql>
```

- add `address` column

```
mysql>
mysql> ALTER TABLE hoge ADD address INT UNSIGNED NOT NULL;
Query OK, 0 rows affected (0.13 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql> DESC hoge;
+------------+------------------+------+-----+---------+-------+
| Field      | Type             | Null | Key | Default | Extra |
+------------+------------------+------+-----+---------+-------+
| first_name | varchar(255)     | NO   |     | NULL    |       |
| last_name  | varchar(255)     | NO   |     | NULL    |       |
| address    | int(10) unsigned | NO   |     | NULL    |       |
+------------+------------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql>
```

### COLUMN UPDATE

#### `ALTER TABLE table MODIFY column type;`

`MODIFY` is column **not rename** column type update.

- type change `homhom` column

```
mysql> DESC hoge;
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| homhom | varchar(255) | YES  |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+
1 row in set (0.01 sec)

mysql>
mysql> ALTER TABLE hoge MODIFY homhom VARCHAR(10);
Query OK, 1 row affected (0.03 sec)
Records: 1  Duplicates: 0  Warnings: 0

mysql>
mysql> DESC hoge;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| homhom | varchar(10) | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
1 row in set (0.00 sec)

mysql>
```

#### `ALTER TABLE table CHANGE old_column new_column type;`  

`CHANGE` is column **rename and** column type update.


- `name` column change to `first_name`

```
mysql>
mysql> ALTER TABLE hoge CHANGE name first_name VARCHAR(10) NOT NULL;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql> DESC hoge;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| first_name | varchar(10) | NO   |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
1 row in set (0.00 sec)

mysql>
```


### COLUMN DELETE

- `last_name` column delete

#### ` ALTER TABLE table DROP column;`

```
mysql>
mysql> DESC hoge;
+------------+------------------+------+-----+---------+-------+
| Field      | Type             | Null | Key | Default | Extra |
+------------+------------------+------+-----+---------+-------+
| first_name | varchar(255)     | NO   |     | NULL    |       |
| last_name  | varchar(255)     | NO   |     | NULL    |       |
| address    | int(10) unsigned | NO   |     | NULL    |       |
+------------+------------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql>
mysql> ALTER TABLE hoge DROP last_name;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql> DESC hoge;
+------------+------------------+------+-----+---------+-------+
| Field      | Type             | Null | Key | Default | Extra |
+------------+------------------+------+-----+---------+-------+
| first_name | varchar(255)     | NO   |     | NULL    |       |
| address    | int(10) unsigned | NO   |     | NULL    |       |
+------------+------------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql>
```


### INDEX

### SHOW INDEX

#### ` SHOW INDEX FROM table;`

### CREATE INDEX

#### `ALTER TABLE table ADD INDEX index_name(column);`

### CREATE INDEX AT CREATE TABLE

#### `CREATE TABLE table ( column VARCHAR(191), INDEX index_name (column) );`

```
mysql> CREATE TABLE test (id INT AUTO_INCREMENT, INDEX index_name (id));
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql>
mysql> SHOW CREATE TABLE test;
+-------+------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                 |
|+-------+-----------------------------------------------------------------------------------------------------------------------------+
| test  | CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  KEY `index_name` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
+-------+------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql>
mysql> SHOW INDEX FROM test;
+-------+------------+------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table | Non_unique | Key_name   | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------+------------+------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| test  |          1 | index_name |            1 | id          | A         |           0 |     NULL | NULL   |      | BTREE      |         |               |
+-------+------------+------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
1 row in set (0.01 sec)

mysql>
```

### DROP INDEX

#### `DROP INDEX index_name ON table;`


### FOREIGN KEY

REFERENCES:[MySQL 5.1 リファレンスマニュアル :: 13 ストレージエンジンとテーブルタイプ :: 13.5 InnoDB ストレージ エンジン :: 13.5.6 InnoDB テーブルの作成と利用 :: 13.5.6.4 FOREIGN KEY 制約](http://dev.mysql.com/doc/refman/5.1/ja/innodb-foreign-key-constraints.html)

#### CREATE TABLE AND COLUMN

```
CREATE TABLE parent (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `number` BIGINT UNSIGNED UNIQUE,
  `name` VARCHAR(191),
  `timestamp` TIMESTAMP DEFAULT 0,
  PRIMARY KEY (id))
ENGINE = InnoDB DEFAULT CHARACTER SET utf8;

CREATE TABLE child (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_number` BIGINT UNSIGNED,
  `nickname` VARCHAR(191),
  `timestamp` TIMESTAMP DEFAULT 0,
  CONSTRAINT `number_fk` FOREIGN KEY (`parent_number`) REFERENCES `parent` (`number`),
  PRIMARY KEY (id))
ENGINE = InnoDB DEFAULT CHARACTER SET utf8;
```

> FOREIGN KEY is UNIQUE set.

```
mysql> DESC parent;
+-----------+---------------------+------+-----+---------------------+----------------+
| Field     | Type                | Null | Key | Default             | Extra          |
+-----------+---------------------+------+-----+---------------------+----------------+
| id        | int(10) unsigned    | NO   | PRI | NULL                | auto_increment |
| number    | bigint(20) unsigned | YES  | UNI | NULL                |                |
| name      | varchar(191)        | YES  |     | NULL                |                |
| timestamp | timestamp           | NO   |     | 0000-00-00 00:00:00 |                |
+-----------+---------------------+------+-----+---------------------+----------------+
4 rows in set (0.02 sec)

mysql>
mysql> DESC child;
+---------------+---------------------+------+-----+---------------------+----------------+
| Field         | Type                | Null | Key | Default             | Extra          |
+---------------+---------------------+------+-----+---------------------+----------------+
| id            | int(10) unsigned    | NO   | PRI | NULL                | auto_increment |
| parent_number | bigint(20) unsigned | YES  | MUL | NULL                |                |
| nickname      | varchar(191)        | YES  |     | NULL                |                |
| timestamp     | timestamp           | NO   |     | 0000-00-00 00:00:00 |                |
+---------------+---------------------+------+-----+---------------------+----------------+
4 rows in set (0.00 sec)

mysql>
```

## FOREIGN KEY CHECK

#### `SHOW CREATE TABLE table;`

```
mysql>
mysql> SHOW CREATE TABLE parent\G
*************************** 1. row ***************************
       Table: parent
Create Table: CREATE TABLE `parent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)

mysql>
mysql> SHOW CREATE TABLE child\G
*************************** 1. row ***************************
       Table: child
Create Table: CREATE TABLE `child` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_number` bigint(20) unsigned DEFAULT NULL,
  `nickname` varchar(191) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `number_fk` (`parent_number`),
  CONSTRAINT `number_fk` FOREIGN KEY (`parent_number`) REFERENCES `parent` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)

mysql>
```

### FOREIGN KEY DROP

#### `ALTER TABLE table DROP FOREIGN KEY foreign_key;`

- drop `number_fk` foreign key

```
mysql> ALTER TABLE child DROP FOREIGN KEY number_fk;
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql>
mysql> SHOW CREATE TABLE child;
+-------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                                                                                                                                                                                                          |
+-------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| child | CREATE TABLE `child` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_number` bigint(20) unsigned DEFAULT NULL,
  `nickname` varchar(191) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `number_fk` (`parent_number`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8 |
+-------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.01 sec)

mysql>
```

### FOREIGN KEY RESTRICT (NO ACTION same means)

#### `ALTER TABLE table ADD CONSTRAINT foreign_key FOREIGN KEY (master_column) REFERENCES table(secondly_column) ON UPDATE RESTRICT ON DELETE RESTRICT;`

```
mysql>
mysql> ALTER TABLE child ADD CONSTRAINT number_fk FOREIGN KEY (parent_number) REFERENCES parent(number) ON UPDATE RESTRICT ON DELETE RESTRICT;
Query OK, 200 rows affected (0.03 sec)
Records: 200  Duplicates: 0  Warnings: 0

mysql>
mysql> SHOW CREATE TABLE child;
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                 |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| child | CREATE TABLE `child` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,  `parent_number` bigint(20) unsigned DEFAULT NULL,  `nickname` varchar(191) DEFAULT NULL,  `timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',  PRIMARY KEY (`id`),  KEY `number_fk` (`parent_number`),  CONSTRAINT `number_fk` FOREIGN KEY (`parent_number`) REFERENCES `parent` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8 |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> 
mysql> UPDATE parent SET number = '201' WHERE id = '100';
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`hoge`.`child`, CONSTRAINT `number_fk` FOREIGN KEY (`parent_number`) REFERENCES `parent` (`number`))
mysql>
mysql> DELETE FROM parent WHERE id = '100';
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`hoge`.`child`, CONSTRAINT `number_fk` FOREIGN KEY (`parent_number`) REFERENCES `parent` (`number`))
mysql>
```

### FOREIGN KEY CASCADE

#### `ALTER TABLE table ADD CONSTRAINT foreign_key FOREIGN KEY (master_column) REFERENCES table(secondly_column) ON UPDATE CASCADE ON DELETE CASCADE;`

```
mysql>
mysql> ALTER TABLE child DROP FOREIGN KEY number_fk;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql>
mysql> ALTER TABLE child ADD CONSTRAINT number_fk FOREIGN KEY (parent_number) REFERENCES parent(number) ON UPDATE CASCADE ON DELETE CASCADE;
Query OK, 200 rows affected (0.03 sec)
Records: 200  Duplicates: 0  Warnings: 0

mysql>
mysql>
mysql> SHOW CREATE TABLE child;
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| child | CREATE TABLE `child` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_number` bigint(20) unsigned DEFAULT NULL,
  `nickname` varchar(191) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `number_fk` (`parent_number`),
  CONSTRAINT `number_fk` FOREIGN KEY (`parent_number`) REFERENCES `parent` (`number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8 |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.01 sec)

mysql>
```

```
mysql> UPDATE parent SET number = '201' WHERE id = '100';
Query OK, 1 row affected (0.11 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> SELECT id, number FROM parent WHERE id = '100';
+-----+--------+
| id  | number |
+-----+--------+
| 100 |    201 |
+-----+--------+
1 row in set (0.00 sec)

mysql>
mysql> SELECT id, parent_number FROM child WHERE id = '100';
+-----+---------------+
| id  | parent_number |
+-----+---------------+
| 100 |           201 |
+-----+---------------+
1 row in set (0.00 sec)

mysql>
mysql>
mysql> DELETE FROM parent WHERE id = '100';
Query OK, 1 row affected (0.00 sec)

mysql>
mysql>
mysql> SELECT id, number FROM parent WHERE id = '100';
Empty set (0.00 sec)

mysql>
mysql> SELECT id, parent_number FROM child WHERE id = '100';
Empty set (0.00 sec)

mysql>
mysql>
mysql>
```

### FOREIGN KEY SET NULL

#### `ALTER TABLE table ADD CONSTRAINT foreign_key FOREIGN KEY (master_column) REFERENCES table(secondly_column) ON UPDATE SET NULL ON DELETE SET NULL;`

```
mysql>
mysql> ALTER TABLE child DROP FOREIGN KEY number_fk;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE child ADD CONSTRAINT number_fk FOREIGN KEY (parent_number) REFERENCES parent(number) ON UPDATE SET NULL ON DELETE SET NULL;
Query OK, 199 rows affected (0.03 sec)
Records: 199  Duplicates: 0  Warnings: 0

mysql>
mysql>
mysql> UPDATE parent SET number = '202' WHERE id = '101';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql>
mysql> SELECT id, number FROM parent WHERE id = '101';
+-----+--------+
| id  | number |
+-----+--------+
| 101 |    202 |
+-----+--------+
1 row in set (0.00 sec)

mysql>
mysql> SELECT id, parent_number FROM child WHERE id = '101';
+-----+---------------+
| id  | parent_number |
+-----+---------------+
| 101 |          NULL |
+-----+---------------+
1 row in set (0.00 sec)

mysql>
mysql> DELETE FROM parent WHERE id = '101';
Query OK, 1 row affected (0.00 sec)

mysql>
mysql> SELECT id, number FROM parent WHERE id = '101';
Empty set (0.00 sec)

mysql>
mysql> SELECT id, parent_number FROM child WHERE id = '101';
+-----+---------------+
| id  | parent_number |
+-----+---------------+
| 101 |          NULL |
+-----+---------------+
1 row in set (0.00 sec)

mysql>
```



### EXPLAIN

[MySQL 5.1 リファレンスマニュアル :: 6 最適化 :: 6.2 SELECTステートメントおよびその他のクエリの最適化 :: 6.2.1 EXPLAINを使用して、クエリを最適化する](http://dev.mysql.com/doc/refman/5.1/ja/explain.html)

#### id

SELECT識別子。クエリ内におけるこの SELECTの順序番号。

#### select_type

SIMPLE	単純なSELECT (UNIONやサブクエリを使用しない)。
PRIMARY	最外部のSELECT。
UNION	内の第２およびそれ以降のSELECTステートメント。
DEPENDENT UNION	UNION内の第2およびそれ以降のSELECTステートメント内のUNION、外側のサブクエリに依存する。
UNION RESULT	UNIONの結果。
SUBQUERY	サブクエリ内の第一SELECT。
DEPENDENT SUBQUERY	第１SELECT、外側のサブクエリに依存する。
DERIVED	派生テーブルSELECT （FROM節内のサブクエリ)
UNCACHEABLE SUBQUERY	結果がキャッシュされず、外側のクエリの各行ごとに再評価されるサブクエリ。


#### table

アクセスする対象のテーブル。読んで字のごとくである。

#### type

参考：[MySQLのEXPLAINを徹底解説!! / 漢のコンピュータ道](http://dev.mysql.com/doc/refman/5.1/ja/explain.html)

type|説明
----|----------------
const|PRIMARY KEYまたはUNIQUEインデックスのルックアップによるアクセス。最速。
eq_ref|JOINにおいてPRIARY KEYまたはUNIQUE KEYが利用される時のアクセスタイプ。constと似ているがJOINで用いられるところが違う。
ref|ユニーク（PRIMARY or UNIQUE）でないインデックスを使って等価検索（WHERE key = value）を行った時に使われるアクセスタイプ。
range|インデックスを用いた範囲検索。
index|フルインデックススキャン。インデックス全体をスキャンする必要があるのでとても遅い。
ALL|フルテーブルスキャン。インデックスがまったく利用されていないことを示す。OLTP系の処理では改善必須。



### Extra

オプティマイザがどのようにクエリを発行したかを解説してくれているフィールド

Extra | 説明
------|-----
Using where|頻繁に出力される追加情報である。WHERE句に検索条件が指定されており、なおかつインデックスを見ただけではWHERE句の条件を全て適用することが出来ない場合に表示される。
Using index|クエリがインデックスだけを用いて解決できることを示す。Covering Indexを利用している場合などに表示される。
Using filesort|filesort（クイックソート）でソートを行っていることを示す。Using filesortについては先日詳しく説明したので参照されたい。
Using temporary|JOINの結果をソートしたり、DISTINCTによる重複の排除を行う場合など、クエリの実行にテンポラリテーブルが必要なことを示す。
Using index for group-by|MIN()/MAX()がGROUP BY句と併用されているとき、クエリがインデックスだけを用いて解決できることを示す。
Range checked for each record (index map: N)|JOINにおいてrangeまたはindex_mergeが利用される場合に表示される。
Not exists|LEFT JOINにおいて、左側のテーブルからフェッチされた行にマッチする行が右側のテーブルに存在しない場合、右側のテーブルはNULLとなるが、右側のテーブルがNOT NULLとして定義されたフィールドでJOINされている場合にはマッチしない行を探せば良いということを示す。



#### EXPLAINでみるところ

1. id/select_type/tableフィールドを見て、どのテーブルがどの順序でアクセスされるのかを知る。これらはクエリの構造を示すフィールドであると言える。サブクエリが含まれている場合にはEXPLAINの表示順とアクセスされる順序が異なる場合があるので気をつける必要がある。
1. type/key/ref/rowsフィールドを見て、各テーブルから行がどのようにフェッチされるのかを知る。どのテーブルへのアクセスが最も重いか（クエリの性能の足を引っ張っているのか）を、これらのフィールドから判断することが出来る。
3. Extraフィールドを見て、オプティマイザがどのように判断して、各々のテーブルへのアクセスにおいて何を実行しているのかを知る。Extraフィールドはオプティマイザの挙動を示すものであり、クエリの全体像を把握するのに役立つ。
