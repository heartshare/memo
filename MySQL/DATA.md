## JOIN

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
mysql> SELECT parent.id AS p_id, child.id AS c_id, name, nickname FROM parent INNER JOIN child ON parent.id = child.id WHERE parent.id = 200 OR parent.id = 210 OR child.id = 211;
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
mysql> SELECT parent.id AS p_id, child.id AS c_id, name, nickname FROM parent LEFT JOIN child ON parent.id = child.id WHERE parent.id = 200 OR parent.id = 210 OR child.id = 211;
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



```
mysql> SELECT parent.id AS p_id, child.id AS c_id, name, nickname FROM parent RIGHT JOIN child ON parent.id = child.id WHERE parent.id = 200 OR parent.id = 210 OR child.id = 211;
+------+------+------------------+-----------+
| p_id | c_id | name             | nickname  |
+------+------+------------------+-----------+
|  200 |  200 | Erasmus Phillips | Pickett   |
| NULL |  211 | NULL             | test test |
+------+------+------------------+-----------+
2 rows in set (0.00 sec)

mysql>
```

```
mysql>
mysql> SELECT * FROM parent WHERE id = '108';
+-----+--------+----------+---------------------+
| id  | number | name     | timestamp           |
+-----+--------+----------+---------------------+
| 108 |    108 | Ray Berg | 2011-06-16 08:53:34 |
+-----+--------+----------+---------------------+
1 row in set (0.00 sec)

mysql>
mysql> UPDATE parent SET name = NULL WHERE id = '108';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> SELECT * FROM parent WHERE id = '108';
+-----+--------+------+---------------------+
| id  | number | name | timestamp           |
+-----+--------+------+---------------------+
| 108 |    108 | NULL | 2011-06-16 08:53:34 |
+-----+--------+------+---------------------+
1 row in set (0.00 sec)

mysql>
mysql> SELECT * FROM child WHERE id = '108';
+-----+---------------+----------+---------------------+
| id  | parent_number | nickname | timestamp           |
+-----+---------------+----------+---------------------+
| 108 |           108 | Jackson  | 2010-07-26 19:21:40 |
+-----+---------------+----------+---------------------+
1 row in set (0.00 sec)

mysql>
mysql> UPDATE child SET nickname = NULL WHERE id = '108';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> SELECT * FROM child WHERE id = '108';
+-----+---------------+----------+---------------------+
| id  | parent_number | nickname | timestamp           |
+-----+---------------+----------+---------------------+
| 108 |           108 | NULL     | 2010-07-26 19:21:40 |
+-----+---------------+----------+---------------------+
1 row in set (0.00 sec)

mysql>
```

## FOREIGN KEY

REFERENCES:[MySQL 5.1 リファレンスマニュアル :: 13 ストレージエンジンとテーブルタイプ :: 13.5 InnoDB ストレージ エンジン :: 13.5.6 InnoDB テーブルの作成と利用 :: 13.5.6.4 FOREIGN KEY 制約](http://dev.mysql.com/doc/refman/5.1/ja/innodb-foreign-key-constraints.html)

### CREATE TABLE AND COLUMN

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

### FOREIGN KEY CHECK

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

### INNER JOIN

#### `SELECT column.table_one, column.table_two FROM table_one INNER JOIN table_two ON table_one.column = table_two.column WHERE table_one.column = 'one' OR table_one.column = 'two';
`

```
mysql>
mysql> SELECT * FROM parent LIMIT 2;
+----+--------+------------------+---------------------+
| id | number | name             | timestamp           |
+----+--------+------------------+---------------------+
|  1 |      1 | Tyrone Underwood | 2013-01-28 11:11:54 |
|  2 |      2 | Gregory Savage   | 2011-02-03 02:35:18 |
+----+--------+------------------+---------------------+
2 rows in set (0.01 sec)

mysql> SELECT * FROM child LIMIT 2;
+----+---------------+----------+---------------------+
| id | parent_number | nickname | timestamp           |
+----+---------------+----------+---------------------+
|  1 |             1 | Lang     | 2014-01-30 19:42:37 |
|  2 |             2 | Hayden   | 2013-10-20 23:07:52 |
+----+---------------+----------+---------------------+
2 rows in set (0.00 sec)

mysql>
mysql> SELECT parent.id, parent.name, child.nickname, child.timestamp FROM parent INNER JOIN child ON parent.id = child.id LIMIT 2;
+----+------------------+----------+---------------------+
| id | name             | nickname | timestamp           |
+----+------------------+----------+---------------------+
|  1 | Tyrone Underwood | Lang     | 2014-01-30 19:42:37 |
|  2 | Gregory Savage   | Hayden   | 2013-10-20 23:07:52 |
+----+------------------+----------+---------------------+
2 rows in set (0.00 sec)

mysql>
mysql> SELECT parent.id, parent.name, child.nickname, child.timestamp FROM parent INNER JOIN child ON parent.number = child.parent_number WHERE parent.name = 'Zeus Ellis';
+-----+------------+----------+---------------------+
| id  | name       | nickname | timestamp           |
+-----+------------+----------+---------------------+
| 154 | Zeus Ellis | Ball     | 2013-06-18 15:20:19 |
+-----+------------+----------+---------------------+
1 row in set (0.00 sec)

mysql>
```

```
mysql>
mysql> EXPLAIN SELECT p.id, p.name, c.nickname, c.timestamp FROM parent AS p INNER JOIN child AS c ON p.id = c.id WHERE p.id = '100';
+----+-------------+-------+-------+---------------+---------+---------+-------+------+-------+
| id | select_type | table | type  | possible_keys | key     | key_len | ref   | rows | Extra |
+----+-------------+-------+-------+---------------+---------+---------+-------+------+-------+
|  1 | SIMPLE      | p     | const | PRIMARY       | PRIMARY | 4       | const |    1 | NULL  |
|  1 | SIMPLE      | c     | const | PRIMARY       | PRIMARY | 4       | const |    1 | NULL  |
+----+-------------+-------+-------+---------------+---------+---------+-------+------+-------+
2 rows in set (0.01 sec)

mysql>
```
