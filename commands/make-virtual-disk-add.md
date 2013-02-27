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
