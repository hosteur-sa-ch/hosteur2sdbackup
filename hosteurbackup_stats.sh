#!/bin/bash
source /root/hosteur2sdbackup/.restic_var
SERVICE="restic"

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
d=`date +%Y-%m-%dT%T`
curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_statsv2/_doc -d '{"hostname":"'$host'", "repos":"'$RESTIC_REPOSITORY'", "size":'$size', "nb_obj":'$num', "@timestamp":"'$d'"}' 