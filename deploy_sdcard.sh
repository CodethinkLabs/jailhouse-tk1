#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
then echo "Please run as root"
        exit 1
fi

SDCARD=$1
MOUNTPOINT=/media/sdcard

echo "cleaning up folders if there's been a previous build"
./cleanup.sh
echo "clean up complete"


echo "Creating open-source graphics stack on L4T FS"
cd graphics_openstack
vagrant up
cd ..

./create_linux_sys.sh $SDCARD
if [ $? -ne 0 ]
then
    echo "Creation of L4T system unsuccessful. Abort"
    exit 1
fi

#Build using cross-compile vagrant box, then 
#deploy generated files to sdcard
vagrant up

if [ ! -d rootfs ]
then echo "rootfs folder not found"
    exit 1
fi

mkdir -p rootfs/boot/extlinux
mkdir -p rootfs/etc/init
mkdir -p rootfs/home/ubuntu
cp kernel_config/extlinux.conf rootfs/boot/extlinux
cp kernel_config/ttyS0.conf rootfs/etc/init
cp jailhouse_config/*.sh rootfs/home/ubuntu

mkdir -p $MOUNTPOINT
mount $SDCARD $MOUNTPOINT
rsync -aH rootfs/ $MOUNTPOINT
sync
umount $MOUNTPOINT
if [ $? -eq 0 ]
then
    echo "Deployment complete!"
fi


