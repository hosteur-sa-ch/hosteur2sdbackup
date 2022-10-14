#!/bin/bash
cd /root/
yum install curl -y
yum install jq -y
yum install restic -y
yum install git -y
apt install curl -y
apt install jq -y
apt install restic -y
apt install git -y

git clone https://github.com/hosteur-sa-ch/hosteur2sdbackup.git
chmod +x /root/hosteur2sdbackup/hosteurbackup.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_stats.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_dobackup.sh


source /root/hosteur2sdbackup/.restic_var
restic init 