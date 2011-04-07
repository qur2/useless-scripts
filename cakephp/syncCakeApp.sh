#!/bin/bash

#
# Scipt to synchronize a cakephp application FROM a remote host using rsync and ssh.
# You have to specify the remote host and the current working directory will be synced.
# Optionally, you can specify the folders to sync. If no folders are specified, 
# then the default ones for cakephp will be chosen automatically (except the config folder).
#
# @author Aurélien Scoubeau <aurelien.scoubeau@tagexpert.com>
#

# script filename
self="syncCakeApp.sh"

# check that at least an arg is given
if [ $# -lt 1 ]
then
	echo "Usage is $self host [folderX .. folderY]"
	exit 1
fi

# the host for rsync must be the 1st arg
host=$1
# shift the 1st arg, remaining ones are folders to sync
shift
# default folder list to sync if none are provided
dirs=( models views controller locale tests webroot vendors )

# if there remain args, replace default folder list by those args
if [ $# -gt 0 ]
then
	unset dirs
	dirs=$@
fi

# build the rsync command to execute
cmd="rsync -rvz"
for dir in ${dirs[@]}
do
	cmd="$cmd --include='$dir' --include='$dir/*'"
done
cmd="$cmd --exclude='*' $host ./"

# warn the user and show the command that's about to be executed
echo "You are about to execute $cmd"
# ask for confirmation
read -p "Do you confirm ? (y | n) "

if [ $REPLY != "y" ]
then # if it wasn't confirmed, abort
	echo "aborted."
else # else, eval the command
	eval $cmd
	if [ $? == "0" ]
	then # if the command was successfully executed, say ok
		echo "done."
	else # else, say ko
		echo "an error occurred."
	fi
fi
