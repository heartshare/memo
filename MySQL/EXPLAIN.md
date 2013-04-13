[MySQL 5.1 リファレンスマニュアル :: 6 最適化 :: 6.2 SELECTステートメントおよびその他のクエリの最適化 :: 6.2.1 EXPLAINを使用して、クエリを最適化する](http://dev.mysql.com/doc/refman/5.1/ja/explain.html)

id

SELECT識別子。クエリ内におけるこの SELECTの順序番号。

select_type

SIMPLE	単純なSELECT (UNIONやサブクエリを使用しない)。
PRIMARY	最外部のSELECT。
UNION	内の第２およびそれ以降のSELECTステートメント。
DEPENDENT UNION	UNION内の第2およびそれ以降のSELECTステートメント内のUNION、外側のサブクエリに依存する。
UNION RESULT	UNIONの結果。
SUBQUERY	サブクエリ内の第一SELECT。
DEPENDENT SUBQUERY	第１SELECT、外側のサブクエリに依存する。
DERIVED	派生テーブルSELECT （FROM節内のサブクエリ)
UNCACHEABLE SUBQUERY	結果がキャッシュされず、外側のクエリの各行ごとに再評価されるサブクエリ。


table

アクセスする対象のテーブル。読んで字のごとくである。

### type

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



## EXPLAINでみるところ

1. id/select_type/tableフィールドを見て、どのテーブルがどの順序でアクセスされるのかを知る。これらはクエリの構造を示すフィールドであると言える。サブクエリが含まれている場合にはEXPLAINの表示順とアクセスされる順序が異なる場合があるので気をつける必要がある。
1. type/key/ref/rowsフィールドを見て、各テーブルから行がどのようにフェッチされるのかを知る。どのテーブルへのアクセスが最も重いか（クエリの性能の足を引っ張っているのか）を、これらのフィールドから判断することが出来る。
3. Extraフィールドを見て、オプティマイザがどのように判断して、各々のテーブルへのアクセスにおいて何を実行しているのかを知る。Extraフィールドはオプティマイザの挙動を示すものであり、クエリの全体像を把握するのに役立つ。
