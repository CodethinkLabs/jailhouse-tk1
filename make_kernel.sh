#!/bin/bash
#Assuming we are in a linux source dir, will make the kernel and install the requisite
#images, dtb files, modules, firmware and headers in a user specified directory

set -e
if [ $# -ne 2 ]
then
    echo "Incorrect number of arguments supplied. STOP"
    exit 1
fi

VAGRANTDIR=$1
KDIR=$2


#Apply: zImage, dtb files, modules, firmware and header to a specified rootfs
make  ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- O=../_linux_out oldconfig
rm .config
make -j4 ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- O=../_linux_out dtbs zImage modules

mkdir -p $VAGRANTDIR/$KDIR/boot
cp ../_linux_out/arch/arm/boot/zImage $VAGRANTDIR/$KDIR/boot/
cp ../_linux_out/arch/arm/boot/dts/*.dtb $VAGRANTDIR/$KDIR/boot/
make -j4 ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- O=../_linux_out INSTALL_MOD_PATH=$VAGRANTDIR/$KDIR modules_install
make -j4 ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- O=../_linux_out INSTALL_FW_PATH=$VAGRANTDIR/$KDIR/lib/firmware firmware_install
make -j4 ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- O=../_linux_out INSTALL_HDR_PATH=$VAGRANTDIR/$KDIR/usr headers_install

cp -ar ../linux-stable $VAGRANTDIR
cp -ar ../_linux_out $VAGRANTDIR
