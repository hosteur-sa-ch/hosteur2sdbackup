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
ip=`hostname -I | awk -F ' '  '{print $2;}'`
curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_stats/_doc -d '{"hostname":"'$host'", "hostip":"'$ip'", "size":'$size', "nb_obj":'$num'}' 
if [$host == "veeamrepo04-mrs2.hosteur.net"]; then
  	repos09 = `ssh restic@10.128.0.86 "df -h | grep /dev/sda2" | awk -F ' ' '{print $5;}'`
	repos08 = `ssh restic@10.128.0.90 "df -h | grep /dev/sda2" | awk -F ' ' '{print $5;}'`
	curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_repos/_doc -d '{"hostname":"veeamrepo09-hostelyon", "used_percent":'$repos09'}'
	curl -H 'Content-Type: application/json' -XPOST -u $RESTIC_OPS_LOGIN $RESTIC_OPS_URL/resticbkp_repos/_doc -d '{"hostname":"veeamrepo08-hostelyon", "used_percent":'$repos08'}'
fi