#!/bin/bash
echo "$(cat /home/$USER/.bash_history | sort -u)"