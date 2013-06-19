## BIG-IP SSL証明書更新

### 証明書と鍵をインポート

#### Local Traffic  ››  SSL Certificates

Certificates  => 証明書をインポート
Keyタブに移動 => 鍵をインポート

### 中間証明書をインポート

#### Local Traffic  ››  SSL Certificates

Certificates  => 中間証明書をインポート


### SSLプロファイルを作成

#### Local Traffic  ››  Profiles : SSL : Client

Name : tekitou

Certificates : 証明書を指定
Key : 鍵を指定 (上のようにひとつにしてたらCertificatesと同じ)

Chain : 中間証明書を指定

### 既存のバーチャルサーバに適用

#### Local Traffic  ››  Virtual Servers : Virtual Server List  ››  hoge_https

SSL Profile => 上のプロファイルを指定

ブラウザなどで確認


