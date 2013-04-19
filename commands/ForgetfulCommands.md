# 忘れがちなコマンドたち

## git commit author

`git commit --author="NAME <MAILADDR>" -v -m`

"NAME <MAILADDR>" じゃないとエラーになる



## ext4 format

```bash
$ fdisk /dev/hoge
$ mkfs.ext4 /dev/hoge
```

## surround.vim

```
"hoge" -> hoge
```
`ds"`
  
```
hoge -> "hoge"
```
`ysw"`
  
```
hoge -> {hoge}
```
`ysw}`

## vim outline

zO 全部開く
zC 全部閉じる


## EasyMotion

`'w`  
`'b`

## strace

`strace -e open,write,close`


## ページインページアウト 

`cat /proc/PID/stat | cut -d" " -f2,10,12`

## dovecotのパスワードをftpasswdでつくる

`ftpasswd --passwd --name hoge@example.com --uid UID -gid GID --home /home/dovecot --shell /sbin/nologin --file /etc/dovecot/dovecot.passwd`
```
hoge@example.com:PASS:UID:GID::/home/dovecot:/sbin/nologin
```


## tmux

アサインされているキーバインド一覧表示
`:list-keys`
