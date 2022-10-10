cd /root/hosteur2sdbackup
echo "Do script Update" >>/var/log/hosteurbackup.log
git fetch && git stash && git pull  >>/var/log/hosteurbackup.log
chmod +x /root/hosteur2sdbackup/hosteurbackup.sh
source /root/hosteur2sdbackup/.restic_var
sh /root/hosteur2sdbackup/hosteurbackup_dobackup.sh
