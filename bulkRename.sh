#!/bin/bash
if [[ "$#" == 2 ]]
then
    PREFIX=$1
    DIR=$2 #directory
    COUNT=1
    if [ ! -d "$DIR" ]
    then
        echo "We are unable to locate the specified directory"
    else
        if [ "${DIR: -1}" != / ]
        then
            DIR+="/"
        fi
        #for FILE in $(find $DIR -maxdepth 1 -type f -exec basename {} \;)
        for FILE in $(find $DIR -maxdepth 1 -type f)
        do
            #echo "$FILE"
            if ((COUNT < 10))
            then
                mv $FILE $DIR$PREFIX"0"$COUNT
            else
                mv $FILE $DIR$PREFIX$COUNT
            fi
            COUNT=$((COUNT + 1))
        done
    fi
else
    echo "You must supply a single prefix followed by a directory as arguements"
fi