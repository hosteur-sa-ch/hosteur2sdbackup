# hosteur2sdbackup
Second Backup Script

## How To Install

1 . Clone Repo
```
cd /root/
git clone https://github.com/hosteur-sa-ch/hosteur2sdbackup.git
chmod +x /root/hosteur2sdbackup/hosteurbackup.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_stats.sh
chmod +x /root/hosteur2sdbackup/hosteurbackup_dobackup.sh
#Centos like
yum install curl -y
yum install jq -y
yum install restic -y
#Debian like
apt install curl -y
apt install jq -y
apr install restic -y

source /root/hosteur2sdbackup/.restic_var
restic init 
```

2 . Add connection variable create a file named .restic_var into repo folder with thoses variables & values

```
export RESTIC_REPOSITORY=
export RESTIC_PASSWORD=
export RESTIC_BACKUPREPO=
export GOMAXPROCS=8
export RESTIC_UPLOAD_LIMIIT=150000
export RESTIC_OPS_LOGIN=
export RESTIC_OPS_URL=
```

3 . Create a cron like 
```
0 14 1-31/2 * * /root/hosteur2sdbackup/hosteurbackup.sh >/dev/null 2>&1
```
