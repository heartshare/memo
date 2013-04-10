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


