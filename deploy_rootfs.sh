#!/bin/bash

set -e

SDCARD=$1
MOUNTPOINT=$2

if [ ! -d rootfs ]
then echo "rootfs folder not found"
    exit 1
fi

mkdir -p rootfs/boot/extlinux
cp kernel_config/extlinux.conf rootfs/boot/extlinux

mkdir -p $MOUNTPOINT
mount $SDCARD $MOUNTPOINT
rsync -aH rootfs/ $MOUNTPOINT
sync
umount $MOUNTPOINT
if [ $? -eq 0 ]
then
    echo "Deployment complete!"
fi


