#!/bin/bash
choice () {
    case "$1" in
        "1")  echo -e "\nRetrieving OS Info:"
            eval uname -a
            ;;
        "2")  echo -e "\nHostName:"
            eval hostname
            ;;
        "3")  echo -e "\nNetwork Info:"
            eval ss -a
            ;;
        "4")  echo -e "\nIP Address:"
            eval ip addr
            ;;
        "5")  echo -e "\nUsers Logged In:"
            eval who -u
            ;;
        "6")  echo -e "\nDisk Usage:"
            eval df -a
            ;;
        "7")  echo -e "\nProcess List:"
            eval ps
            ;;
        *)    echo -e "\nInvalid Option"
            ;;
    esac

    read -p "Press enter to continue..." GARBAGE
    echo `clear`

}

while [[ $OPTION != "8" ]]
do
    echo "------------------
    Menu:
    ------------------
    1. OS Info
    2. Hostname
    3. Network info
    4. IP Address only
    5. Users logged in
    6. Disk Usage
    7. Process list
    8. Exit
    Enter your choice [ 1 - 8 ]"

    read OPTION
    if [[ $OPTION != "8" ]]
    then
        choice $OPTION
    fi
done


echo `clear`