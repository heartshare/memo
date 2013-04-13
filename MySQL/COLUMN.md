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

### ORDER BY

#### NORMAL or ASC

```
mysql>
mysql> mysql> SELECT name, number FROM homhom ORDER BY number;
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

#### DESC

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


