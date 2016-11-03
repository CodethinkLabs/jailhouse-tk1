#!/bin/bash
#Extracts L4T FS (currently R21.5.0) to an sdcard.
#

MOUNT_POINT="mnt_point"
SDCARD=$1

if [ "$EUID" -ne 0 ]
then echo "Please run as root"
	exit 1
fi

mkdir -p $MOUNT_POINT
mount $SDCARD $MOUNT_POINT
if [ $? -ne 0 ]
then echo "Mounting of $SDCARD failed"
    exit 1
fi

source deploy_config
echo "Extracting L4T FS Archive"
if [ ! -f "$PREPARED_ROOTFS_NAME" ]
then echo "L4T FS not present!"
    exit 1
fi

cd $MOUNT_POINT

tar xpf ../$PREPARED_ROOTFS_NAME
if [ $? -ne 0 ]
then echo "Extraction of L4T FS archive failed"
    umount $MOUNT_POINT
    exit 1
fi
cd ..

sync
umount $MOUNT_POINT
rm -r $MOUNT_POINT
echo "SD card ready"

