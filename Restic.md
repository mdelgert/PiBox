### Links
https://restic.readthedocs.io/en/stable/010_introduction.html
https://restic.readthedocs.io/en/stable/040_backup.html#scheduling-backups
https://forum.restic.net/t/safe-method-of-passing-repo-password-to-scheduled-task-on-synology-nas/1343

### setup restic
sudo apt install restic
restic version
restic init --repo ~/backup
restic -r ~/backup --verbose backup ~/test
restic -r ~/backup snapshots
restic -r ~/backup restore 34869e94 --target ~/restore
restic -r ~/backup restore 34869e94 --target ~/restore --include /home/mdelgert/test/test1.txt

### backup hourly 
crontab -e
0 * * * * sudo /home/mdelgert/shared/source/PiBox/restic_hourly.sh