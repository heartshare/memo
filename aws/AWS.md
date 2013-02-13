# あとでためす 
 
- RDSのメモ書く  
- S3やる
- EIPのテスト  
- RDSのテスト  
- ELBのテスト  
- tag?  
- CloudFormation?  
- S3バケット  
  
ネットワークアクセスコントロールリスト  
Amazon S3 にデータを格納し、Amazon VPC からのみデータにアクセスできるといったような権限も設定できます。  
  
Amazon Virtual Private Cloud の使用には、通常の Amazon EC2 の使用料以外には、追加料金はかかりません。  
  
# 各種メモ

### AIM(Identity and Access Management)  

Services => AIM を選択  
アカウントを選択した後Create Access Keyを選択  
Download Credentialsでcsvファイルができるので  
その中に鍵ファイルが2つできてる  
  
### アベイラビリティゾーン（AZ）  
  
リージョン内でデータセンターを分けてる
  

### EIP
  
EIPを振るとDNSは振られなく鳴る

---
  
# EC2  
  
### エフェメラルディスク  

 [インスタンスサイズ毎の割り振り一覧](http://macedoniashooter.blogspot.jp/2012/09/aws.html)

 - インスタンス再起動したら消える  
 - Terminate Protectとかして誤って削除されないように保護できる  
 - あとから付け足せない  

  
  
### ルートパーティション拡張  
  
- 作成時のxvda領域については拡張できない  
- 作成時のxvda領域はEBSなのでVolumesに載ってる  
  
  
1. 普通にEC2のインスタンスつくる  
2. インスタンスを落とす  
3. Volumesから作成されたインスタンスのルートボリュームをDetach  
4. DetachされたVolumeからSnapshotを作成  
5. SnapshotからVolumeを作成(この時にディスクサイズ指定)  
6. 作成されたボリュームで対象のインスタンスをAttach(Deviceは ***/dev/sda1*** を指定)  
7. インスタンスを起動  
8. *fdisk -l* などで認識しているディスクサイズが変わったことを確認して  
9. *resize2fs /dev/xvda1*  
  
---
  
# S3  
  
git clone git://github.com/s3tools/s3cmd.git  
  
  
### EIP  
  
- EC3落ちたら切り離される  
- EIPをallocateするとDNSが使えなくなる  
  
切り替えられるっぽい***  
  
RDSはMulti-AZ機能を保持している  
  
  
---
  
# RDS
  
### VPC内でRDS  

 - CIDR = 許可IP  
  
VPCのサブネットを2つのAZに確保しておく    
(DB Subnet Groupの仕様上)  
  
  
1. EC2のInstance作成時にEC2かVPCか選択できるのでVPCを選択  
  
EIP -> VPC  
  
Internet Gatewayつくる  
  
1. EIP -> VPC dekinai  
  
  
  

