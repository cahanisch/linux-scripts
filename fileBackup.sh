#!/bin/bash
FILE=$1	#backup file
if [[ "$#" == 1 ]]
then
    EXT=`echo "$FILE" | cut -d"." -f 2`
    FILENAME=`echo "$FILE" | cut -d"." -f 1`
    BACKUP=`echo "backup.$EXT"`
    echo "Creating $BACKUP of $FILE"

    cat $FILE > $BACKUP
else
    echo "You must pass in 1 file to backup"
fi