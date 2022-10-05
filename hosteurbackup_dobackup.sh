#!/bin/bash
SERVICE="restic"

if pgrep -x "$SERVICE" >/dev/null
then
	echo "backup already running" >>/var/log/hosteurbackup.log
else
	restic backup --limit-upload $RESTIC_UPLOAD_LIMIT --tag Scheduled $RESTIC_BACKUPREPO >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	restic forget --keep-daily 7 --keep-monthly 1 --keep-yearly 1 --tag Scheduled >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	restic prune >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
	resticsnap=`restic snapshots --json`
	items=$(echo "$resticsnap" | jq -c -r '.[]')
	for item in ${items[@]}; do
		echo ${item}
		curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_snap/_doc -d ${item}
	done
	resticstats=`restic stats --json`
	size=$(echo "$resticstats" | jq '.total_size')
	num=$(echo "$resticstats" | jq '.total_file_count')
	host=`hostname`
	ip=`hostname -I | awk -F ' '  '{print $2;}'`
	curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_stats/_doc -d '{"hostname":"'$host'", "hostip":"'$ip'", "size":'$size', "nb_obj":'$num'}'
fi