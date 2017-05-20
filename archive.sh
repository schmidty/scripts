#!/usr/bin/env bash
#
# Daily archiving program to back up desktop and western digital harddrive files under schmidty account
# It does NOT BACKUP Git directories
#
#

SHORTDATE=`date +%F`
NOW=`date '+%Y-%m-%d %H:%M:%S'`

echo "archive.bash run with list of files copied from '/home/schmidty/' to '/media/schmidty/td_backup/desktop_daily_archive/' at time $NOW" > /tmp/archive.$SHORTDATE.txt
echo '' >> /tmp/archive.$SHORTDATE.txt

/usr/bin/rsync -arv /home/schmidty/bin/ /media/schmidty/td_backup/desktop_daily_archive/bin --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Books/ /media/schmidty/td_backup/desktop_daily_archive/Books --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Databases/ /media/schmidty/td_backup/desktop_daily_archive/Databases --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Documents/ /media/schmidty/td_backup/desktop_daily_archive/Documents --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Downloads/ /media/schmidty/td_backup/desktop_daily_archive/Downloads --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Dropbox/ /media/schmidty/td_backup/desktop_daily_archive/ --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Economics/ /media/schmidty/td_backup/desktop_daily_archive/Economics --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Finances/ /media/schmidty/td_backup/desktop_daily_archive/Finances --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/five-star/ /media/schmidty/td_backup/desktop_daily_archive/five-star --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Music/ /media/schmidty/td_backup/desktop_daily_archive/wd/Music --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/MyMusic /media/schmidty/td_backup/desktop_daily_archive/wd/MyMusic --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Pictures/ /media/schmidty/td_backup/desktop_daily_archive/Pictures --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Projects/ /media/schmidty/td_backup/desktop_daily_archive/Projects --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Public/ /media/schmidty/td_backup/desktop_daily_archive/Public --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Repos/ /media/schmidty/td_backup/desktop_daily_archive/Repos --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Templates/ /media/schmidty/td_backup/desktop_daily_archive/Templates --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/TestDir/ /media/schmidty/td_backup/desktop_daily_archive/TestDir --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt
/usr/bin/rsync -arv /home/schmidty/Videos/ /media/schmidty/td_backup/desktop_daily_archive/Videos --exclude '.git' &>> /tmp/archive.$SHORTDATE.txt

# Create some space...
echo '' >> /tmp/archive.$SHORTDATE.txt
echo '' >> /tmp/archive.$SHORTDATE.txt

echo "-- end of list --" >> /tmp/archive.$SHORTDATE.txt
chown schmidty:schmidty /tmp/archive.$SHORTDATE.txt
chmod 775 /tmp/archive.$SHORTDATE.txt

# Send an email with a list of files copied as
# NOTE: bash application 'mail' must be installed
#
if [ `wc -l /tmp/archive.$SHORTDATE.txt | cut -f1 -d' '` -gt 750 ] ;
then
	# Attach zipped file list to email
	/bin/bzip2 /tmp/archive.$SHORTDATE.txt
	echo "attached zipped list of files" | /usr/bin/mailx -s "desktop archive for $SHORTDATE " -A "/tmp/archive.$SHORTDATE.txt.bz2" schmidty99203@gmail.com
else
	# Print out file list of 50 or less lines copied to email message body
	/usr/bin/mail -s "desktop archive for $SHORTDATE " "schmidty99203@gmail.com" < /tmp/archive.$SHORTDATE.txt
fi
