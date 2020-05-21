#!/bin/bash

echo -e "1) The kernel version\\n"$(uname -r)
echo -e "2) The total number of user on the system\\n"$(cat /etc/passwd | wc -l)
echo -e "3) A list of user accounts on the system\\n"$(cat /etc/passwd | cut -d":" -f 1 | sed s/" "/\\n/g)
echo -e "4) The total number of commands the root user has run\\n"$(cat /root/.bash_history | wc -l)
echo -e "5) A de-duplicated list of users that have actually logged at some point\\n"$(who | cut -d" " -f 1 | sort -u)
echo -e "6) A list of any \".txt\" files on the system\\n"$(find / -iname "*.txt")
echo -e "7) A list of any files in /root or /home containing the word \"documentation\"\\n"$(grep -r "documentation" /root | cut -d"/" -f 3 | cut -d":" -f 1; grep -r "documentation" /home | cut -d"/" -f 3 | cut -d":" -f 1)
echo -e "8) The number of processors available on the machine\\n"$(sed -n 13p /proc/cpuinfo  | cut -d":" -f 2)
echo -e "9) A list of devices in /dev beginning with \"sd...\"\\n"$(find /dev -iname "sd*" | cut -d"/" -f 3)
echo -e "10)The /dev/sd... device file that the root filesystem (/) is mounted on\\n"$(mount -l | grep -h " / " | cut -d" " -f 1)