#!/bin/bash
#Builds Jailhouse, will also build a binary of freeRTOS which can be executed
#within a non-root cell

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

#Clone freeRTOS. We want to copy over specific non-root cell,
#to be built during a jailhouse build
git clone -b jetson-tk1 https://github.com/CodethinkLabs/freertos-cell.git
cp freertos-cell/jailhouse-configs/*.c jailhouse/configs/

#Copy TK1 specific files over and make and install jailhouse
cd jailhouse
git checkout b267f36bfd9583425a7d151c977c4f5d602421e3

#Jailhouse build
cp $VAGRANTDIR/jailhouse_config/*.c configs
cp $VAGRANTDIR/jailhouse_config/config.h hypervisor/include/jailhouse/config.h
make ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- KDIR=$KDIR
make ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- KDIR=$KDIR DESTDIR=$VAGRANTDIR/$DESTDIR install
mkdir -p $VAGRANTDIR/$DESTDIR/usr/src/jailhouse
cp -ar configs $VAGRANTDIR/$DESTDIR/usr/src/jailhouse
cp -ar inmates $VAGRANTDIR/$DESTDIR/usr/src/jailhouse
cd ..

#FreeRTOS build
cd freertos-cell
make
make install INSTALL_DIR=$VAGRANTDIR/$DESTDIR/usr/src/jailhouse/inmates/demos/arm/
