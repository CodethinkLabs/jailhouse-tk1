#!/bin/bash

set -e
if [ "$EUID" -ne 0 ]
then echo "Please run as root"
        exit 1
fi

SDCARD=$1
MOUNTPOINT=/media/sdcard

./create_linux_sys.sh $SDCARD
if [ $? -ne 0 ]
then
    echo "Creation of L4T system unsuccessful. Abort"
    exit 1
fi

#Build using cross-compile vagrant box, then 
#deploy generated files to sdcard
vagrant up

./deploy_rootfs.sh $SDCARD $MOUNTPOINT


