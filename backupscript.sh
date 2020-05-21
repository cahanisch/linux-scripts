#!/bin/bash

OPTION=$1	#backup or restore
DIRECTORY=$2	#directory
RDATE=$3	#requested date
TSTAMP=`date "+%m-%d-%Y-%H%M"` #gets current date and time
FCHAR=$(echo $DIRECTORY | cut -c1)
if [[ $OPTION == "" ]]	       #checks to see if they didn't have an arugement with the script
then
	echo "Missing option to backup or restore"
elif [[ $OPTION == "backup" ]] #checks to see if they selected backup
then
	if [[ -d $DIRECTORY ]] #checks to see if the directory they want to backup exists
	then
		if [[ $FCHAR != "/" ]]	#will check to see the directory has a leading / ex. /etc or /home do (we don't want that if we don't do the whole path)
		then
			FORMAT_DIR=$(echo -n $DIRECTORY | head -c -1| sed -e 's/\//-/g')
		else
			FORMAT_DIR=$(echo -n $DIRECTORY | tail -c +2 | head -c -1 | sed -e 's/\//-/g')
		fi
		FILENAME=$(echo $FORMAT_DIR"-"$TSTAMP".tar.xz")
		FULL_PATH=$(echo "/home/caleb/backups/"$FILENAME)
		echo $FULL_PATH
		tar cJ $DIRECTORY | ssh caleb@138.247.100.146 "cat > $FULL_PATH"
	elif [[ $DIRECTORY == "" ]] #checks to see if they selected a directory to backup
	then
		echo "Please specify a directory"
	else			    #the directory they specified doesn't exist
		echo "The specified directory doesn't exists"
	fi
elif [[ $OPTION == "restore" ]] #checks to see if they chose the restore option
then
	if [[ $RDATE == "" ]]	#checks to see if they chose a date to backup from
	then
		echo "Please enter a date when using the restore option"
	else
		if [[ $FCHAR != "/" ]]	#will check to see the directory has a leading / ex. /etc or /home do (we don't want that if we don't do the whole path)
		then
			FORMAT_DIR=$(echo -n $DIRECTORY | head -c -1| sed -e 's/\//-/g')
		else
			FORMAT_DIR=$(echo -n $DIRECTORY | tail -c +2 | head -c -1 | sed -e 's/\//-/g')
		fi
		FILENAME=$(echo $FORMAT_DIR"-"$RDATE".tar.xz")
		FULL_PATH=$(echo "/home/caleb/backups/"$FILENAME)
		ssh caleb@138.247.100.146 "test -e $FULL_PATH" 			#checks to see if the file exists
		if [[ $? -eq 0 ]]						#checks to see if the file exists
		then
			ssh caleb@138.247.100.146 "cat $FULL_PATH" | tar xJ
		else			#the file exists doesn't exists
			echo "The specifed file can not be found"
		fi
	fi
else	#they have invalid arguements passed to the script
	echo "Invalid option. Please run again using either backup or restore"
fi
