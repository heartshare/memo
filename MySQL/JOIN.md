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

LEFTの逆。あんまり使わないらしい

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
