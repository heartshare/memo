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
  
### パブリックサブネットIP
  
あとで変えられない
  
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

# ELB

直感でできる

---
  
# S3  
  
git clone git://github.com/s3tools/s3cmd.git  
  
  
### EIP  
  
- EC2をTerminatしない限り関連付けからは外れなくなる
- EIPをallocateするとDNSが使えなくなる  
  
切り替えられるっぽい***  
  
RDSはMulti-AZ機能を保持している  
  
  
---
  
# RDS
  
### Provisioned IOPSは後付できない

### VPC内でRDS  
  
 - Create DB Subnet Groupサブネットグループの追加(AZを2つ以上指定)
 - Security Group 許可IPの追加

 - CIDR = 許可IP  
  
VPCのサブネットを2つのAZに確保しておく  
(DB Subnet Groupの仕様上)  
  
先にSubnet Groupつくっておいた方が良い

# COMMAND

ec2-create-snapshot -O ACCESS-KEY -W SECRET-KEY --region REGION(no -1a nad -2b) VOLUME-ID -d DESCRIPTIN


# KVM ディスク増やす

### ダミーデータつくる

`$ qemu-img create -f raw dummy-1G.img 1G`

### ダミーデータをKVMのイメージのケツに足す

`$ ls -ls kvm-image.img`   
`$ ls -lh kvm-image.img`

`hoge.sh`
```bash
#!/bin/bash

COUNT=1

while [ ${COUNT} -ge 1 ];
do
    cat dummy-1G.img >> kvm-image.img
    echo "$COUNT"
    sleep 30
    COUNT=`expr ${COUNT} - 1`
done
```

`$ sh -x hoge.sh`   
`$ ls -ls kvm-image.img`   
`$ ls -lh kvm-image.img`

### パーティションテーブルの再構築

```
$ fdisk -l  
fdisk /dev/拡張領域  
  
fdisk d (拡張領域)  
fdisk n (拡張領域)  

正しい情報になっていることを確認して

w

正しい情報になっていることを確認して
```

### 反映する

```
$ partprobe
$ df -h
$ resize2fs -p /dev/(拡張領域)
$ df -h
```


## LVMの場合


物理機側で qemu-img で作成した 1GB の sparse image を既存イメージファイルの末尾に cat で連結 * 20回  
reboot  
VM側で増えた分を /dev/vda3 として確保。  

```
Disk /dev/vda: 45.0 GB, 45097156608 bytes
255 heads, 63 sectors/track, 5482 cylinders
Units = シリンダ数 of 16065 * 512 = 8225280 bytes

デバイス Boot      Start         End      Blocks   Id  System
/dev/vda1   *           1          13      104391   83  Linux
/dev/vda2              14        2871    22956885   8e  Linux LVM
/dev/vda3            2872        5482    20972857+  8e  Linux LVM
# partprobe
# pvcreate /dev/vda3
# vgextend VolGroup00 /dev/vda3
# lvextend --size +20G /dev/VolGroup00/LogVol00
# resize2fs /dev/VolGroup00/LogVol00
```
