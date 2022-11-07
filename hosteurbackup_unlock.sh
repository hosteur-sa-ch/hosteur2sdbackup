#!/bin/bash
SERVICE="restic"

if pgrep -x "$SERVICE" >/dev/null
then
	echo "backup already running" >>/var/log/hosteurbackup.log
else
	cd /root/hosteur2sdbackup/
    source ./.restic_var
	restic unlock >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
fi