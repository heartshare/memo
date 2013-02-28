```/etc/mdadm.conf 
DEVICE /dev/xvd[cd]
ARRAY /dev/md0 devices=/dev/xvdc,/dev/xvdd
```

```
# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/xvda1            20642428   5448068  14984936  27% /
tmpfs                  3816932         0   3816932   0% /dev/shm
/dev/xvdc            433455904    203012 411234588   1% /media/ephemeral0
/dev/xvdd            433455904    202880 411234720   1% /media/ephemeral1

# /media/ephemeral0
# /media/ephemeral1



# mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/xvd[cd]
mdadm: /dev/xvdc appears to contain an ext2fs file system
    size=440366080K  mtime=Tue Feb 19 21:00:55 2013
mdadm: /dev/xvdc appears to be part of a raid array:
    level=raid0 devices=0 ctime=Thu Jan  1 09:00:00 1970
mdadm: partition table exists on /dev/xvdc but will be lost or
       meaningless after creating array
mdadm: /dev/xvdd appears to contain an ext2fs file system
    size=440366080K  mtime=Tue Feb 26 20:22:01 2013
Continue creating array?
Continue creating array? (y/n) y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.

# cat /proc/mdstat
Personalities : [raid0]
md0 : active raid0 xvdd[1] xvdc[0]
      880731136 blocks super 1.2 512k chunks

unused devices: <none>

```

```
#!/bin/bash

yes | mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/xvd[cd]
mkfs.ext4 /dev/md0
mount /dev/md0 /data/
mkdir /data/redis/
```
