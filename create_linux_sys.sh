#!/bin/bash
#Extracts L4T FS (currently R21.5.0) to rootfs directory.
#

ROOTFS="rootfs"
SDCARD=$1

if [ "$EUID" -ne 0 ]
then echo "Please run as root"
	exit 1
fi

mount $SDCARD $ROOTFS
if [ $? -ne 0 ]
then echo "Mounting of $SDCARD failed"
    exit 1
fi

source deploy_config
echo "Extracting L4T FS Archive"
if [ ! -f "../$PREPARED_ROOTFS_NAME" ]
then echo "L4T FS not present!"
    exit 1
fi

cd $ROOTFS

tar xpf ../../$PREPARED_ROOTFS_NAME
if [ $? -ne 0 ]
then echo "Extraction of L4T FS archive failed"
    cd ..
    umount $ROOTFS
    exit 1
fi
cd ..

sync
umount $ROOTFS
echo "SD card ready"

