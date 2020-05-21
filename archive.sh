#!/bin/bash
OLDFILES=""
DATE=`date "+%b-%d-%Y-%H-%M-%S"` #gets current date and time
if [[ "$#" == 1 ]]
then
    DIR=$1 #directory
    for FILE in $(find $1 -maxdepth 1 -type f -mtime +7 -exec basename {} \;)
    do
        OLDFILES+="${FILE} "
    done
    tar -cvzf $DATE.tar.gz -C $1 $OLDFILES
else
    echo "You must supply a single directory as an arguement"
fi