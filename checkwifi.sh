#!/bin/bash

#copy to  /usr/local/bin
#add to crontab with command: 
#*/5 * * * * /usr/local/bin/checkwifi.sh >> /home/pi/wifi.log 2>&1

ping -c4 10.1.1.1 > /dev/null
 
if [ $? != 0 ] 
then
  echo "No network connection, restarting" | ts '[%Y-%m-%d %H:%M:%S]'
  sudo /sbin/shutdown -r now
else
  echo "Network is Connected." | ts '[%Y-%m-%d %H:%M:%S]'
fi
#then
#  echo "No network connection, restarting wlan0" | ts '[%Y-%m-%d %H:%M:%S]'
#  /sbin/ifdown 'wlan0'
#  sleep 5
#  /sbin/ifup --force 'wlan0'
#else
#  echo "Network is Connected." | ts '[%Y-%m-%d %H:%M:%S]'
#fi

