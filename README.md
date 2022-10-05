# hosteur2sdbackup
Second Backup Script

## How To Install

1 . Clone Repo
```
git clone https://github.com/hosteur-sa-ch/hosteur2sdbackup.git
chmod +x ./hosteur2sdbackup/hosteurbackup.sh
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
0 12 1-31/2 * * /root/hosteur2sdbackup/hosteurbackup.sh >/dev/null 2>&1
```
