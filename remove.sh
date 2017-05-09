#!/usr/bin/env bash
#
# Safe file removal for UNIX/Linux BASH shells
#
# This script is to be used by root user only!
# It clears all users /home/{user}/.Trash files from cron job
#
# The following .bashrc (or .profile) function (see below) will replace a user's 'rm' functionality
# and remove all files in a safe manner to ~/.Trash in their home directory.
#

DATE=`date +%F`
NOW=`date '+%Y-%m-%d %H:%M:%S'`;
USERS=`/usr/bin/awk -F':' '$3 >= 1000 && $1 !="nobody" { print $1; }' /etc/passwd`

for USER in ${USERS[@]};
do
	USER_TRASH_DIR="/home/$USER/.Trash" 

	if [ -d "$USER_TRASH_DIR" ]; then
		echo "Removing trash files for $USER on $(date) "

		# This command should delete ALL files in user's .Trash directory safely
		/usr/bin/find "$USER_TRASH_DIR" -path "$USER_TRASH_DIR/*" -exec /bin/rm -rf {} +
	fi
done

#mail -s "desktop remove for $DATE " "user123@gmail.com" <<< "remove.bash run on '/home/user/' files for $NOW "

# Put the following in ~/.bashrc or ~/.profile files
# 
# function rm () {
#   local path
#   for path in "$@"; do
#     # ignore any arguments
#     if [[ "$path" = -* ]]; then :
#     else
#       local dst=${path##*/}
#       # append the time if necessary
#       while [ -e ~/.Trash/"$dst" ]; do
#         dst="$dst "$(date +%H-%M-%S)
#       done
#       mv "$path" ~/.Trash/"$dst"
#     fi
#   done
# }
# 
