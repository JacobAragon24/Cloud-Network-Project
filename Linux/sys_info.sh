#!/bin/bash

# check if script was run as root
if [ $USER = 'root' ]; then
 echo "dont run script using sudo"
exit
fi
# script variables
output=$HOME/research/sys_info.txt
IP=$(hostname -i)
exe=$(find /home -type f -perm 777)

# check for research directory. create it if needed.
if [ ! -d ~/research ]; then
 mkdir ~/research
fi

# check for output file. remove it if needed.
if [ -f $output ]; then
 rm $output
fi

# system info script
echo "My System Info Script" >> $output
date >> $output
echo "" >> $output
echo -e "\nThis is my machine info:\n" >> $output
echo $MACHTYPE >> $output
echo -e "\nThis is my machines IP address:\n" >> $output
echo -e "$IP \n"  >> $output
echo -e "\nThis is my machines hostname:\n" >> $output
hostname >> $output
echo -e "\nThis is my machines DNS info:\n" >> $output
nslookup all >> $output
echo -e "\nThis is my machines Memory info:\n" >> $output
free -h >> $output
echo -e "\nThis is my machines CPU info:\n" >> $output
lscpu | grep CPU >> $output
echo -e "\nThis is my machines disk usage:\n" >> $output
df -h | head -7 >> $output
echo -e "\nThese are the currently logged on users:\n" >> $output
who >> $output
echo -e "\nThese are my home executable files:\n" >> $output
echo $exe >> $output
echo -e "\nThese are my top 10 currently running processes:\n" >> $output
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $output


