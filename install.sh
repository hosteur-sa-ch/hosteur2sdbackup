cd /root/
git clone https://github.com/hosteur-sa-ch/hosteur2sdbackup.git
chmod +x /root/hosteur2sdbackup/hosteurbackup.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_stats.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_dobackup.sh
yum install curl -y
yum install jq -y
yum install restic -y
apt install curl -y
apt install jq -y
apr install restic -y

source /root/hosteur2sdbackup/.restic_var
restic init 