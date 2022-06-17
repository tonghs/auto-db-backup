#!/bin/sh
echo "Starting ..."
echo "$BAK_SCHEDULE /usr/local/bin/gobackup perform >> /var/log/cron.log 2>&1" > /etc/cron.d/gobackup
# Give execution rights on the cron job
chmod 0644 /etc/cron.d/gobackup
# Apply cron job
crontab /etc/cron.d/gobackup

echo "Done."
