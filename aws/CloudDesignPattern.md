  
# クラウドデザインパターン

### SnapShot
EBSにはスナップショットとしてS3にバックアップする機能がある  
そのスナップショットを利用してAMIを作成することも可能  


### Bootstrapパターン
起動時に色々設定できるようにしておくパターン。  


### Stampパターン
基礎になるような状態のOSのSnapShotを取得しておき、  
OSが必要になった際に利用するパターンL。  


### Scale Up
EC2を落としてインスタンスタイプを変更して再起動  


### Scale Out
インスタンスを増やす  


### Ondemand Diskパターン
EBSを小さめにEC2にアサインしておいて  
必要になったらSnapShot取得してそのSnapShot利用して  
新しいEBSをつくる。  
アタッチした後リサイズコマンドで新しい容量まで領域を拡張する。  
ストライピングを行うことで、ディスクI/Oの性能を向上できる。  
EBSは確保した時点で料金が発生する。  
S3は使用した分だけ課金。  
  
---  

## 可用性の向上

### Multi-Serverパターン
フロントにお金がそんなにかからないから  
最初からELB入れといた方が増やす時に楽だよという話  


### Multi-Datacenterパターン  
ELBとかRDSでAZかますパターン  
  
  
###Floating IPパターン  
EIP使えばIPを数秒程度で入れ替えられる？マジ？  
  
  
### Deep Health Checkパターン  
/pingとか叩いてWEB->APP->DBみたいな感じに見に行って    
DBの中身返すみたいなの  

---

## 動的コンテンツを処理

### Clone Server
ELB配下でAMI使ってEC2たちあげてELB配下にする。  
既存のサーバに一切手を加えなくていける。  
  
  
### NFS Sharingパターン  
NFSを複数台のWEBサーバでマウントする  
  
  
### NFS Replicaパターン  
EBSをNFSのレプリカとして使えばNFSの負荷下げられる  
  
  
### State Sharingパターン  
セッション管理用のKVSを用意しておけば  
スケールアウトしてもセッションを再利用できる  
  
  
### URL Rewritingパターン  
静的なファイルはS3とかCloudFront使えば負荷下げられるって話  
  
  
### Rewrite Proxyパターン  
似たような感じ。コンテンツも別にしたらって話  
  
  
### Cache Proxyパターン  
FrontにVarnishとか入れてみれば  
  
  
### Scheduled Scale Outパターン  
AutoScalingには時間指定できるヤツがあるからそれ使って  
負荷高くなりそうな時間にスケールアウトするとかもできる  
  
---  
  
## 静的コンテンツを処理  
  
### Web Storageパターン  
S3をファイルサーバとして見て、そちらにファイルを置く  
http://aws.clouddesignpattern.org/index.php/CDP:Web_Storage%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3  
  
  
### Direct Hostingパターン  
公開用のファイルをそこに置いてそっち見させる  
  
  
### Private Distributionパターン  
認証用のAPIとか使って特定のアクセスとか外部に渡す方法  
  
  
### Cache Distributionパターン  
フロントにエッジサーバとしてCloudFrontを置く  
実サーバのファイルを向けることも  
  
  
### Private Cache Distributionパターン  
プライベート版  
  
  
### Rename Distributionパターン  
ファイル名変えたりしてアクセス先変更させてみれば  
  
  
### Write Proxyパターン  
UDPとか使えば。  
  
  
### Storage Indexパターン  
KVSで値取ってS3のデータ(共用)取りに行ったりしてみては  
  
  
### Direct Object Uploadパターン  
ファイルアップロードとかEC2使わないで  
直接S3にアップロードさせてみては  
  
  
### DB Replicationパターン  
RDSでMulti-AZ使えば  
  
  
### Read Replicaパターン  
読み取り専用のリードレプリカがある  
  
  
### Inmemory DB Cacheパターン  
ElastiCache使えば  
  
  
### Sharding Writeパターン  
シャーディングしてみては  
  
---  
  
## バッチ処理  
  
### Queuing Chainパターン  
SQS使ってみては  
  
  
### Job Observerパターン  
Auto ScalingとCloudWatch使ってスケールアウトするようにしてみては  
  
---  
  
## 運用保守  
  
### Bootstrapパターン  
Stamp     = 決め打ち  
Bootstrap = 柔軟に対応  
  
  
### Cloud DIパターン  
tag付けてStampとかBootstrapとかで使ってみては  
  
  
### Stack Deploymentパターン  
CloudFormationテンプレートシステムのテンプレート！これはすごい！  
  
  
### Server Swappingパターン  
EC2に障害があったらEBS切り離して予備のEC2に切り替えることもできる  
Zabbixで自動化することもできる  
Floating IPパターンと併用することで、EBSも付け替えるとともに、固定IPアドレスを付け替えることも可能である  
当たり前だけどSnapShotを取っていないとダメ  
  
  
### Monitoring Integrationパターン  
CloudWatch使ってみては  
API叩いたりするの料金かかるよ  
  
  
### Web Storage Archiveパターン  
Amazon Glacierとか使うのよさそう  
  
  
### Weighted Transitionパターン  
Route 53使えばシステム丸っと移動できるとか書いてあるけど  
データの同期とかどうするんだろう  
  
---
  
## ネットワーク  
  
### OnDemand NATパターン  
APCとか使って入り口をNATさせてみては  
  
  
### Backnetパターン  
ENIを2つ持つことができるからひとつを管理用とかにできる  
  
  
### Functional Firewallパターン  
セキュリティパターンというFirewall機能がある  
  
  
### Operational Firewallパターン  
接続元でも制限できるから、開発会社は〜とか色々できる  
  
  
### Multi Load Balancerパターン  
ELBを複数使う。設定が異なるELBを置くことも可能  
  
  
### WAF Proxyパターン  
WAF使う意味よくわからない  
  
  
### CloudHubパターン  
VPC使えばセキュアなネットワークがつくれる  
  
  
  
  
