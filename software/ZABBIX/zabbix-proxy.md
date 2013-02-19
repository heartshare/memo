# ZABBIX PROXYの導入

  
### 環境
  
> #### OS: 
>  Amazon Linux AMI release 2012.09  
> 
> #### RPM:
> zabbix-proxy-1.8.16-1.el6.x86_64  
> zabbix-1.8.16-1.el6.x86_64  
> zabbix-agent-1.8.16-1.el6.x86_64  
> zabbix-proxy-mysql-1.8.16-1.el6.x86_64  
  


### インストール

```
$ install yum zabbix zabbix-proxy zabbix-proxy-mysql  
  
$ mysql  
mysql> CREATE DATABASE zabbix_proxy DEFAULT CHARACTER SET utf8;  
mysql> GRANT ALL PRIVILEGES ON zabbix_proxy.* TO zabbix_proxy@localhost IDENTIFIED BY 'PASSWORD';  
  
$ mysql -u zabbix_proxy -h HOST zabbix_proxy -p PASSWORD < /usr/share/doc/zabbix-proxy-mysql-1.8.16/create/schema/mysql.sql  
$ mysql -u zabbix_proxy -h HOST zabbix_proxy -p PASSWORD < /usr/share/doc/zabbix-proxy-mysql-1.8.16/create/data/data.sql  
$ mysql -u zabbix_proxy -h HOST zabbix_proxy -p PASSWORD < /usr/share/doc/zabbix-proxy-mysql-1.8.16/create/data/images_mysql.sql  
```

### zabbix-proxyの設定

`/etc/zabbix/zabbix_proxy.conf`

```
Server=MAIN-ZABBIX-SERVER
Hostname=PROXY-ZABBIX-SERVER
LogFile=/var/log/zabbix/zabbix_proxy.log
LogFileSize=0
PidFile=/var/run/zabbix/zabbix_proxy.pid
DBHost=PROXY-ZABBIX
DBName=PROXY-ZABBIX_DB
DBUser=PROXY-ZABBIX_DB_USER_NAME
DBPassword=PROXY-ZABBIX_DB_PASSWORD
DBSocket=/var/lib/mysql/mysql.sock
```

みたいな感じで

## ZABBIXのGUIにて

設定 => 分散監視 => プルダウンからプロキシ  

選んでよしなに設定

> この設定気づかなくてずっとハマってた！！！

## 確認

```

# PROXY  
  
$ /etc/init.d/zabbix-proxy start  
$ tail -F /var/log/zabbix/zabbix_proxy.log  
  

# 集約サーバ  
  
$ tail -F /var/log/zabbix/zabbix_server.log | grep PROXY-SERVER  

```

設定箇所さえ知ってれば簡単に導入できて良いですね。
