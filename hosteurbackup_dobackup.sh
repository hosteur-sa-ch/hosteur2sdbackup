#!/bin/bash
SERVICE="restic"
host=`hostname`

if pgrep -x "$SERVICE" >/dev/null
then
	echo "backup already running" >>/var/log/hosteurbackup.log
	d=`date +%Y-%m-%dT%T`
	curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_job/_doc -d '{"hostname":"'$host'", "repos":"'$RESTIC_REPOSITORY'", "@timestamp":"'$d'", "status", "running"}'
else
    source /root/hosteur2sdbackup/.restic_var
	d=`date +%Y-%m-%dT%T`
	curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_job/_doc -d '{"hostname":"'$host'", "repos":"'$RESTIC_REPOSITORY'", "@timestamp":"'$d'", "status", "starting"}'
	restic backup --limit-upload 150000 --tag Scheduled $RESTIC_BACKUPREPO >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	restic forget --keep-daily 7 --keep-monthly 1 --keep-yearly 1 --tag Scheduled >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	restic prune >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	d=`date +%Y-%m-%dT%T`
	curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_job/_doc -d '{"hostname":"'$host'", "repos":"'$RESTIC_REPOSITORY'", "@timestamp":"'$d'", "status", "completed"}'	
	bash /root/hosteur2sdbackup/hosteurbackup_stats.sh
fi