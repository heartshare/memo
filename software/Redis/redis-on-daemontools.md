
# Redisをdaemontoolsで動かす

## 環境 

> A
> redis-2.6.7-1.el6.x86_64  
> daemontools-toaster-0.76-1.3.6.x86_64  
> "`daemonize no`"no  


## rpmをインストール

```
$ yum install redis daemontools  
$ mkdir -p /var/lib/redis/service/log
```

`/var/lib/redis/service/run`

```bash
#!/bin/sh

set -e
exec 2>&1
exec setuidgid redis /usr/sbin/redis-server /etc/redis.conf
```

`/var/lib/redis/service/log/run`

```bash
#!/bin/sh

set -e
exec 2>&1
exec setuidgid nobody multilog t s16777216 n10 .
```

### シンボリックリンクを作成して読み込ませる

```
$ ln -s /var/lib/redis/service/ /service/redis
$ svstat /service/redis/
$ tail /var/log/redis/redis.log
```

