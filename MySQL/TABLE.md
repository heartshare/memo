## ALTER

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

#### `ALTER TABLE table MODIFY colum type;`  

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
