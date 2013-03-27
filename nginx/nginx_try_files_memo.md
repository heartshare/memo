## nginx config

`nginx.conf`
```
server {
    listen 80;
    server_name example.com;
    root /var/www/html/;
    index index.html;
    access_log /var/log/nginx/access_log hogehoge;
    error_log  /var/log/nginx/error_log  error;
    
    try_files $uri $uri/ /hoge.html;
    
}
```

## command line
```
$ cat hoge.html
hoge dayo
$
$ curl http://example.com/hogehogehogeeee
hoge dayo
$
```

## access log
```bash
$ tail access_log
"GET /hogehogehogeeee HTTP/1.1" 200 10 "-" "curl ~
```

## 例えば

[http://wiki.nginx.org/HttpCoreModule#try_files](http://wiki.nginx.org/HttpCoreModule#try_files)

オフィシャルを参考に

```
try_files $uri $uri/ /hoge.html;
```

でexample.com/hoge でアクセスして

`$uri = "hoge"`  
./hoge というファイルが存在しなければ

`$url/ = "hoge/"`  
./hoge/ というディレクトリを探しに行く

`/hoge.html`  
./hoge.html というファイルもなければ  
ステータスコードは ***500*** になる(もうちょっと検証が必要かも)。

```
try_files $uri $uri/ /hoge.html /hogehoge.html;
```
この場合、上の3つを探して見つからない場合は

`/hogehoge.html`  
./hogehoge.html を探しにいく。  
条件はいくらでも増やせる

### 条件の複数指定
```
try_files $uri $uri/ /ho.html /hog.html /hoge.html /hogee.html;
```
これもいけた。

### 条件にステータスコードを渡す
```
try_files $uri $uri/ /hoge.html =404;
```

最後の条件にステータスコードを渡せば  
条件にひっかからなければテータスコードが返る。  
上記の場合は ***404*** が返る。
  
```
try_files $uri $uri/ /hoge.html =404;
```

*./hoge.html* というファイルが存在した場合は  
後ろのステータスコードは無視されステータスコードは ***200*** が返る。
