#!/bin/bash

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

#Build kernel using cross-compile vagrant box, then 
#deploy generated files to sdcard
vagrant up

if [ ! -d rootfs ]
then echo "rootfs folder not found"
    exit 1
fi

mkdir -p rootfs/boot/extlinux
cp extlinux.conf rootfs/boot/extlinux

mkdir -p $MOUNTPOINT
mount $SDCARD $MOUNTPOINT
rsync -aH rootfs/ $MOUNTPOINT
sync
umount $MOUNTPOINT
if [ $? -eq 0 ]
then
    echo "Deployment complete!"
fi


