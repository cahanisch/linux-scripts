echo "A list of user accounts on the system:"
for LINE in $(cat /etc/passwd | cut -d":" -f 1)
do
    echo $LINE
done