# 忘れがちなコマンドたち


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
