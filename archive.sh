#!/usr/bin/env bash
#
# Daily linux archiving rsync archiving application for general back up of /home user accounts
# NOTE: it does NOT BACKUP Git directories
#
#

# make sure we have rsync installed
if ! command -v rsync &>/dev/null ; then
	echo "rsync app is not installed... install this before continuing"
	exit;
fi


# timestamp variables
DATE=`date +%F`
NOW=`date '+%Y-%m-%d %H:%M:%S'`

echo "archive.bash run with list of files copied from '/home/user/' to '/media/user/td_backup/desktop_daily_archive/' at time $NOW" >> /tmp/archive.$DATE.txt

# backup kept in /media/user/td_backup
/usr/bin/rsync -arv /home/user/bin/ /media/user/td_backup/desktop_daily_archive/bin --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Books/ /media/user/td_backup/desktop_daily_archive/Books --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Databases/ /media/user/td_backup/desktop_daily_archive/Databases --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Documents/ /media/user/td_backup/desktop_daily_archive/Documents --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Downloads/ /media/user/td_backup/desktop_daily_archive/Downloads --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Dropbox/ /media/user/td_backup/desktop_daily_archive/ --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Economics/ /media/user/td_backup/desktop_daily_archive/Economics --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Finances/ /media/user/td_backup/desktop_daily_archive/Finances --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/five-star/ /media/user/td_backup/desktop_daily_archive/five-star --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Music/ /media/user/td_backup/desktop_daily_archive/wd/Music --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/MyMusic /media/user/td_backup/desktop_daily_archive/wd/MyMusic --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Pictures/ /media/user/td_backup/desktop_daily_archive/Pictures --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Projects/ /media/user/td_backup/desktop_daily_archive/Projects --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Public/ /media/user/td_backup/desktop_daily_archive/Public --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Repos/ /media/user/td_backup/desktop_daily_archive/Repos --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Templates/ /media/user/td_backup/desktop_daily_archive/Templates --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/TestDir/ /media/user/td_backup/desktop_daily_archive/TestDir --exclude '.git' &> /tmp/archive.$DATE.txt
/usr/bin/rsync -arv /home/user/Videos/ /media/user/td_backup/desktop_daily_archive/Videos --exclude '.git' &> /tmp/archive.$DATE.txt

echo "-- end of list --" >> /tmp/archive.$DATE.txt

# Send an email with a list of files copied as
# NOTE: bash application 'mail' applications must be installed
if [ ! command -v mail &>/dev/null || ! command -v mailx &>/dev/null ] ;
then
	echo "mail and/or mailx apps are not installed... install these before continuing"
	exit;
fi

# mail the results
if [ `wc -l /tmp/archive.$DATE.txt | cut -f1 -d' '` -gt 50 ] ;
then
	# Attach zipped file list to email
	/bin/bzip2 /tmp/archive.$DATE.txt
	echo "attached zipped list of files" | /usr/bin/mailx -s "desktop archive for $DATE " -A "/tmp/archive.$DATE.txt.bz2" user123@gmail.com
else
	# Print out file list of 50 or less lines copied to email message body
	/usr/bin/mail -s "desktop archive for $DATE " "user123@gmail.com" < /tmp/archive.$DATE.txt
fi
