#!/bin/bash
SERVICE="restic"

if pgrep -x "$SERVICE" >/dev/null
then
	echo "backup already running" >>/var/log/hosteurbackup.log
else
    source /root/hosteur2sdbackup/.restic_var
	restic unlock >>/var/log/hosteurbackup.log 2>>/var/log/hosteurbackup_err.log
fi