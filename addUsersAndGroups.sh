#!/bin/bash

IFS=","
FILES=*.csv
for FILE in $FILES
do
    GROUP=$(echo $FILE | cut -d "." -f 1 )
    GEXIST=$(cat /etc/group | cut -d ":" -f 1 | grep -c $GROUP)
    if [ "$GEXIST" -eq 0 ];
    then
        groupadd $GROUP
    fi
    if [ ! -d "/var/classes/$GROUP" ];
    then
        mkdir /var/classes/$GROUP
        chown root:$GROUP /var/classes/$GROUP
        chmod 750 /var/classes/$GROUP
    fi
    while read FNAME LNAME
    do
        SHORT=$(echo $FNAME | cut -b 1)
        USERNAME=$SHORT$LNAME
        USERNAME=$(echo $USERNAME | tr '[:upper:]' '[:lower:]')
        UEXIST=$(cat /etc/passwd | cut -d ":" -f 1 | grep -c $USERNAME)
        if [ "$UEXIST" -eq 0 ];
        then
            useradd -d /home/$USERNAME -m -g users -G $GROUP -s /bin/bash $USERNAME
        else
            usermod -a -G $GROUP $USERNAME
        fi
    done < $FILE
done