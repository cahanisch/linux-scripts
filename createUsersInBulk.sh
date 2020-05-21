#!/bin/bash
USERS=$1
EXISTS=()
if [[ "$#" == 1 ]]
then
    echo "Enter a default password"
    read -s DEFAULT_PASSWORD
    while read USERNAME
    do
        UEXIST=$(cat /etc/passwd | cut -d ":" -f 1 | grep -c $USERNAME)
        if [ "$UEXIST" -eq 0 ];
        then
            sudo useradd -d /home/$USERNAME -m -g users -s /bin/bash $USERNAME
            echo -e "$DEFAULT_PASSWORD\n$DEFAULT_PASSWORD\n" | sudo passwd $USERNAME
            echo `clear`
        else
            EXISTS+=( $USERNAME )
        fi
    done < $USERS
    for i in "${EXISTS[@]}"
    do
        echo "User: $i already exists"
    done | sort -u
else
    echo "You must provide a file with users to add"
fi