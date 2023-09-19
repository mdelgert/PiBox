### Links
https://en.wikipedia.org/wiki/Comparison_of_backup_software
https://en.wikipedia.org/wiki/List_of_backup_software
https://en.wikipedia.org/wiki/BackupPC
https://en.wikipedia.org/wiki/Comparison_of_online_backup_services
https://en.wikipedia.org/wiki/Comparison_of_file_synchronization_software
https://restic.readthedocs.io/en/stable/020_installation.html

### backup at midnight 
crontab -e 
0 0 * * * /bin/bash /home/mdelgert/shared/source/PiBox/rsync_daily.sh

