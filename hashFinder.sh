#!/bin/bash

FIRST="81749d0a1c143b690588721931fa96d1"
SECOND="00a4ae27e6b713c18ed47e335a30529c"
THIRD="2a22fb5344057f7019118d99335fa807"
for LINE in $(find / -type f -not -path "/sys/*" -not -path "/proc/*" -exec md5sum {} + | sed -e "s/ //g");
do
    HASH="$(echo $LINE | cut -d '/' -f 1)"
    if [ "$HASH" == "$FIRST"] || [ "$HASH" == "$SECOND"] || [ "$HASH" == "$THIRD"]
    then
        echo $(echo $LINE | sed 's/\// /1')
    fi
done
