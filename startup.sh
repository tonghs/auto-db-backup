#!/bin/sh
echo "Starting ..."
echo "$BAK_SCHEDULE /usr/local/bin/gobackup perform >> /var/log/cron.log 2>&1" >> /etc/crontabs/root
echo "Done."
