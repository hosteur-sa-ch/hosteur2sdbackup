cd /root/hosteur2sdbackup
echo "Do script Update" >>/var/log/hosteurbackup.log
git fetch && git stash && git pull  >>/var/log/hosteurbackup.log
chmod +x ./hosteurbackup.sh
source ./.restic_var
sh hosteurbackup_dobackup.sh
