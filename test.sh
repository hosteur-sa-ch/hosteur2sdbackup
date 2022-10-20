#!/bin/bash
ls -lh /var/log/hosteurbackup.log && ls -lh /var/log/hosteurbackup_err.log && tail -20 /var/log/hosteurbackup.log && tail -20 /var/log/hosteurbackup_err.log && ps ax | grep restic