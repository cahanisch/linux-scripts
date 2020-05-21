#!/bin/bash
MATCHES=()
if [[ "$#" == 1 ]]
then
    DIR=$1 #directory
    FILES=$(ls -p $DIR | grep -v /)
    echo "Files with the same the same hash values: "
    for FILE in $FILES
    do
        HASH=$(md5sum $FILE | cut -d"/" -f 1 | cut -d" " -f 1)
        for LINE in $(find $DIR -type f \( ! -name "$FILE" \) -exec md5sum {} + | cut -d"/" -f 1);
        do
            if [[ "$HASH" == "$LINE" ]]
            then
                MATCH=$(echo "$LINE:$FILE")
                MATCHES+=( $MATCH )
            fi
        done
    done
    for i in "${MATCHES[@]}"
    do
        echo "$i"
    done | sort -u
    
else
    echo "You must supply a directory as an arguement"
fi