#!/bin/sh
# 2 args needed : a folder and a simple pattern (no regexp) to run with grep
if [ $# -ne 2 ]; then
	echo "Usage is : script folder grep"
	exit 1
fi

playlist=() # start with empty list
for f in "$1"*; do # for each item in arg 1
	match=$(ls "$f" | grep "$2") # check that it's ok with grep
	if [ -f "$f" ] && [ "$match" ]; then # if it's a recognized file
		playlist=("${playlist[@]}" "$f") # add it to the list
	fi
done

# now loop through dirlist, operating on each one
for match in "${playlist[@]}"; do
	printf "Playing: %s\n" "$match"
	afplay "$match"
done
