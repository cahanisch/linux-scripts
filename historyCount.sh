#!/bin/bash
echo "Number of commands the user has run: $(cat /home/$USER/.bash_history | sort -u | wc -l)"