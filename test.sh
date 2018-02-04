#!/bin/bash
echo "This Script will add a Samba Share for the motioneye Camera Program"
echo "e.g. /var/lib/motioneye/Camera1"
echo -n "Enter Camera Directory Name: "
read HANDLE

if [ ! -r "$HANDLE" ]
then
    echo "$HANDLE is not readable... Exiting... Please try again.";
    # if not, exit with an exit code != 0
    exit 2;
fi

echo -n "Share Name? eg Camera1: "
read SHARENAME

echo "[$SHARENAME]" >> /etc/samba/smb.conf
echo "    path = $HANDLE"  >> /etc/samba/smb.conf
echo "    create mask = 0700" >> /etc/samba/smb.conf
echo "    read only = no" >> /etc/samba/smb.conf
