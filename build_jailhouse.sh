#!/bin/bash

if [ $# -ne 3 ]
then
    echo "Incorrect number of arguments supplied. STOP"
    exit
fi

VAGRANTDIR=$1
KDIR=$2
DESTDIR=$3

#install the dependencies required for jailhouse building
apt-get install -y flex bison python-mako
git clone https://github.com/siemens/jailhouse.git

#Copy TK1 specific files over and make and install jailhouse
cd jailhouse
cp $VAGRANTDIR/jailhouse_config/jetson-tk1.c configs/jetson-tk1.c
cp $VAGRANTDIR/jailhouse_config/config.h hypervisor/include/jailhouse/config.h
make ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- O=$KDIR -C $VAGRANTDIR/linux-stable M=. modules 
make ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- O=$KDIR -C $VAGRANTDIR/linux-stable M=. DESTDIR=$VAGRANTDIR/$DESTDIR modules_install
mkdir -p $VAGRANTDIR/$DESTDIR/usr/src/jailhouse
cp -ar configs $VAGRANTDIR/$DESTDIR/usr/src/jailhouse
