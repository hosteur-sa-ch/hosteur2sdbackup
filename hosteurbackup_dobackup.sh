#!/bin/bash
SERVICE="restic"

if pgrep -x "$SERVICE" >/dev/null
then
	echo "backup already running" >>/var/log/hosteurbackup.log
else
	restic backup --limit-upload $RESTIC_UPLOAD_LIMIT --tag Scheduled $RESTIC_BACKUPREPO >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	restic forget --keep-daily 7 --keep-monthly 1 --keep-yearly 1 --tag Scheduled >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	restic prune >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	sh hosteurbackup_stats.sh
fi