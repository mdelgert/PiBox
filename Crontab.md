### Add cron jobs

```bash
crontab -e
```

# Backup Daily at 2:00 AM
0 2 * * * /home/mdelgert/shared/source/PiBox/rsync_daily.sh

# Backup Weekly at 2:00 AM
0 2 * * 0 /home/mdelgert/shared/source/PiBox/rsync_weekly.sh
