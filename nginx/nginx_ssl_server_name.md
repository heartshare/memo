[http://nginx.org/en/docs/http/configuring_https_servers.html](http://nginx.org/en/docs/http/configuring_https_servers.html)  
[http://nginx.org/ja/docs/http/configuring_https_servers.html](http://nginx.org/ja/docs/http/configuring_https_servers.html)  

## default_server 

default_serverは対象のポートに対して有効だから  
下記のようにポート毎にデフォルトサーバを指定できる。

```
server {
    listen       80;
    listen       8080  default_server;
    server_name  example.net;
    ...
}

server {
    listen       80  default_server;
    listen       8080;
    server_name  example.org;
    ...
}
```

## catch-all

どの *server_name* にも引っかからなかった場合  
catch-allとして受け入れるserverをつくっておいた方が安全。  
設定は ***_*** で指定。

```
server {
    listen       80  default_server;
    server_name  _;
    return       444;
}
```


## サブドメインを指定しない場合の設定

```
server {
    listen       80;
    server_name  example.org  www.example.org  *.example.org;
    ...
}
```

こうやって書かなくても

```
server {
    listen       80;
    server_name  .example.org;
    ...
}
```

dotを先頭に書くことで有効になるとのこと。知らなかった。


## SSL

### SSLの設定

```
server {
    listen               443;
    server_name          www.example.com;
    ssl                  on;
    ssl_certificate      www.example.com.crt;
    ssl_certificate_key  www.example.com.key;
    ssl_protocols        SSLv3 TLSv1;
    ssl_ciphers          HIGH:!ADH:!MD5;
    ...
```

もしくは

```
server {
    listen               443 ssl;
    server_name          www.example.com;
    ssl_certificate      www.example.com.crt;
    ssl_certificate_key  www.example.com.key;
    ssl_protocols        SSLv3 TLSv1;
    ssl_ciphers          HIGH:!ADH:!MD5;
    ...
```

でもOK。

```
server {
    listen               443;
    server_name          www.example.com;
    ssl                  on;
    ssl_certificate      www.example.com.cert;
    ssl_certificate_key  www.example.com.cert;
    ssl_protocols        SSLv3 TLSv1;
    ssl_ciphers          HIGH:!ADH:!MD5;
    ...
```

秘密鍵と証明書が同じファイルの場合は、上記のように設定する。  
また、 *80番ポート* でSSLを受け付けることもできる。  

```
server {
    listen               80;
    server_name          www.example.com;
    ssl                  on;
    ssl_certificate      www.example.com.cert;
    ssl_certificate_key  www.example.com.cert;
    ssl_protocols        SSLv3 TLSv1;
    ssl_ciphers          HIGH:!ADH:!MD5;
    ...
```

### SSLのセッションキャッシュを有効化してCPUの負荷を減らす

セッション発生する事にSSLのセッションつくらないで  
ワーカー間でセッションを使いまわしてCPUの負荷を減らしたり  
 *keeepalive* を有効にしたりしてなるべく効率的にセッションを回す。  
*ssl_session_timeout* はデフォルトは ***5m*** 。


```
server {
    listen              443 ssl;
    keepalive_timeout   70;

    ssl_protocols       sslv3 tlsv1 tlsv1.1 tlsv1.2;
    ssl_ciphers         aes128-sha:aes256-sha:rc4-sha:des-cbc3-sha:rc4-md5;
    ssl_certificate     /usr/local/nginx/conf/cert.pem;
    ssl_certificate_key /usr/local/nginx/conf/cert.key;
    ssl_session_cache   shared:ssl:10m;
    ssl_session_timeout 10m;

    ...
}
```

### 同じIPアドレスで複数のSSLを待ち受けてもデフォルトサーバにしかアクセスが行われない。

```
server {
    listen           443;
    server_name      www.example.com;
    ssl              on;
    ssl_certificate  www.example.com.crt;
    ...
}

server {
    listen           443;
    server_name      www.example.org;
    ssl              on;
    ssl_certificate  www.example.org.crt;
    ...
}
```

上記の設定の場合、最初の *www.example.com* が認識されてしまう。  
この場合の対策は  

```
server {
    listen           192.168.2.1:443;
    server_name      www.example.com;
    ssl              on;
    ssl_certificate  www.example.com.crt;
    ...
}

server {
    listen           192.168.2.2:443;
    server_name      www.example.org;
    ssl              on;
    ssl_certificate  www.example.org.crt;
    ...
}
```

こんな感じでIPアドレスを分けて割り振るのが確実で良いらしい。
