#!/bin/bash

#copy to  /usr/local/bin
#add to crontab with command: 
#*/5 * * * * /usr/local/bin/checkwifi.sh >> /home/pi/wifi.log 2>&1

RED='\033[0;31m'
NC='\033[0m' # No Color
#printf "I ${RED}love${NC} Stack Overflow\n"

command -v ts >/dev/null 2>&1 || { echo -e >&2 "I ${RED}require ts ${NC}but it's not installed. \nInstall with ${RED}sudo apt-get -y install moreutils${NC} \nAborting."; exit 1; }
usage="
  Usage:
    checkwifi.sh -r will run the script
    checkwifi.sh -i will install the script
"

croncmd="/usr/local/bin/checkwifi.sh -r >> /home/pi/wifi.log 2>&1"
cronjob="*/5 * * * * $croncmd"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if  [[ $1 = "-i" ]]; then
  #The below section will copy the script to  BINDIR
  DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
  BINDIR="/usr/local/bin"
  if [[ $DIR != $BINDIR && -w $BINDIR ]]; then
    echo "
This script is being run outside of $BINDIR with the intall command so will be installed
It will also be added to cron and run every 5min.
Edit the crontab if you want to change frequency.
"
    cp "${BASH_SOURCE[0]}" $BINDIR
    #add to crontab will not make duplicate entries
    ( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
    #if needed later the below command would remove from crontab
    ( crontab -l | grep -v -F "$croncmd" ) | crontab -
  else
    echo "
This script is already installed.. Exiting.
"
    exit 1
  fi
  elif [[ $1 = "-r" ]]; then
    ping -c4 10.1.1.1 > /dev/null

    if [ $? != 0 ]; then
      echo "No network connection, restarting" | ts '[%Y-%m-%d %H:%M:%S]'
      sudo /sbin/shutdown -r now
    else
      echo "Network is Connected." | ts '[%Y-%m-%d %H:%M:%S]'
    fi
  else
    echo "$usage"
fi

#then
#  echo "No network connection, restarting wlan0" | ts '[%Y-%m-%d %H:%M:%S]'
#  /sbin/ifdown 'wlan0'
#  sleep 5
#  /sbin/ifup --force 'wlan0'
#else
#  echo "Network is Connected." | ts '[%Y-%m-%d %H:%M:%S]'
#fi

