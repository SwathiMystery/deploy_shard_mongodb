#!/bin/sh
## For i2.2xlarge instances only
sudo su
sudo yum -y update
df -h
cat /proc/partitions 
sudo fdisk -l
yum install lvm2
fdisk -l
umount /mnt
pvcreate /dev/xvdb /dev/xvdc
vgcreate vg  /dev/xvdb /dev/xvdc
lvcreate -L1300G -n lv_data vg
lvdisplay 
vgdisplay 
mkfs -t ext4 /dev/vg/lv_data 
mkdir -p /data
mount /dev/vg/lv_data /data/
df -h
lvcreate -L60G -n lv_journal vg
lvcreate -L40G -n lv_log vg
mkfs -t ext4 /dev/vg/lv_journal 
mkfs -t ext4 /dev/vg/lv_log 
mkdir -p /journal
mkdir -p /log
mount /dev/vg/lv_journal /journal/
mount /dev/vg/lv_log /log/
df -h
echo "[MongoDB]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64
gpgcheck=0
enabled=1" | sudo tee -a /etc/yum.repos.d/mongodb.repo
 
sudo yum install -y mongo-10gen mongo-10gen-server
df -h
sudo chown -R mongod:mongod /data /journal /log
 
echo '/dev/mapper/vg-lv_data /data ext4 defaults,auto,noatime,noexec 0 0
 /dev/mapper/vg-lv_journal /journal ext4 defaults,auto,noatime,noexec 0 0
  /dev/mapper/vg-lv_log /log ext4 defaults,auto,noatime,noexec 0 0' | sudo tee -a /etc/fstab
   
df -kh
sudo blockdev --setra 32  /dev/mapper/vg-lv_data 
echo 'ACTION=="add", KERNEL=="mapper/vg-lv_data", ATTR{bdi/read_ahead_kb}="16"' | sudo tee -a /etc/udev/rules.d/85-ebs.rules
sudo yum install -y sysstat
sudo ln -s /journal /data/journal
