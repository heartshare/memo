## DATA

### SAMPLE TABLE

```
mysql>
mysql> DESC homhom;
+--------+---------------------+------+-----+---------------------+-------+
| Field  | Type                | Null | Key | Default             | Extra |
+--------+---------------------+------+-----+---------------------+-------+
| name   | varchar(191)        | YES  |     | NULL                |       |
| number | bigint(20) unsigned | YES  |     | NULL                |       |
| date   | timestamp           | NO   |     | 0000-00-00 00:00:00 |       |
+--------+---------------------+------+-----+---------------------+-------+
3 rows in set (0.00 sec)

mysql>
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


