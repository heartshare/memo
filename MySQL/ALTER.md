## ALTER

### CREATE TABLE

`CREATE TABLE table column type;`  

- create name column

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

### TABLE ADD

`ALTER TABLE table ADD column type;`

- add last_name column

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

- add address column

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

### TABLE UPDATE

`ALTER TABLE table CHANGE old_column new_column type;`  

- type change `name` column

```
mysql>
mysql> ALTER TABLE hoge CHANGE name name VARCHAR(10);
Query OK, 0 rows affected (0.00 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql> DESC hoge;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(10) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
1 row in set (0.10 sec)
```


- `name` column change NOT NULL

```
mysql>
mysql> ALTER TABLE hoge CHANGE name name VARCHAR(10) NOT NULL;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql> DESC hoge;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(10) | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
1 row in set (0.00 sec)

mysql>
```


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


### TABLE DELETE

- `last_name` column delete

` ALTER TABLE table DROP column;`

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