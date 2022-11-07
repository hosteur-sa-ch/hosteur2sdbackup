#!/bin/bash
cd /root/hosteur2sdbackup
echo "Do script Update" >>/var/log/hosteurbackup.log
git fetch && git stash && git pull  >>/var/log/hosteurbackup.log
chmod +x /root/hosteur2sdbackup/hosteurbackup.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_stats.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_dobackup.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_unlock.sh
echo "Update restic" >>/var/log/hosteurbackup.log
restic self-update
/root/hosteur2sdbackup/hosteurbackup_unlock.sh
/root/hosteur2sdbackup/hosteurbackup_dobackup.sh
