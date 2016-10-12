#!/bin/bash
#Creates L4T (currently R21.5.0) to roofs directory on L4T folder
#
#Makes a L4T system from fs and kernel, and applies tegra specific
#binaries as well.

L4T_FS_ARCHIVE="l4t-Jetson-TK1-Sample-Root-Filesystem-R21-5.tbz2"
L4T_LINUX_ARCHIVE="Tegra124_Linux_R21.5.0_armhf.tbz2"

SDCARD=$1

if [ "$EUID" -ne 0 ]
then echo "Please run as root"
	exit 1
fi

echo "Extracting L4T Linux Archive"
if [ !  -f "$L4T_LINUX_ARCHIVE" ]
then wget "http://developer.download.nvidia.com/embedded/L4T/r21_Release_v5.0/Tegra124_Linux_R21.5.0_armhf.tbz2"
fi
 
tar xpf $L4T_LINUX_ARCHIVE
if [ $? -ne 0 ]
then echo "Extraction of L4T linux Archive failed"
    exit 1
fi

cd Linux_for_Tegra

mount $SDCARD rootfs
if [ $? -ne 0 ]
then echo "Mounting of $SDCARD failed"
    exit 1
fi

echo "Extracting L4T FS Archive"
if [ ! -f "../$L4T_FS_ARCHIVE" ]
then wget "http://developer.nvidia.com/embedded/dlc/l4t-Jetson-TK1-Sample-Root-Filesystem-R21-5"
fi

cd rootfs
tar xpf ../../$L4T_FS_ARCHIVE
if [ $? -ne 0 ]
then echo "Extraction of L4T FS archive failed"
    cd ..
    umount rootfs
    exit 1
fi
cd ..

echo "Applying binaries"
./apply_binaries.sh

sync
umount rootfs
echo "SD card ready"

