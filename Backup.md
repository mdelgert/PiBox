### backup at midnight 
crontab -e 
0 0 * * * /bin/bash /home/mdelgert/shared/source/PiBox/rsync_daily.sh