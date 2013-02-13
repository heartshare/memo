# ローカルにgit立てる

`Server`
```bash
mkdir /tmp/repo.git
cd /tmp/repo.git
git init --bare --shared
```

`Client`
```bash
mkdir /tmp/hoge
cd /tmp/hoge
git init
git remote add origin ssh://server/tmp/repo.git
echo "hoge" > hoge
git add .
git commit -m "1st"
git push origin master
```


