#!/bin/bash
#Top level build of the kernel within a Vagrant VM, installing cross-compiler dependencies as well.

sudo -i
VAGRANTPATH=$1
KERNELVER=$2

#Add the debian cross-toolchain repository
apt-get install -y curl git
echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/crosstools.list
curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | sudo apt-key add -

#Install the cross-compiler architecture
sudo dpkg --add-architecture armhf
sudo apt-get update
apt-get install -y  crossbuild-essential-armhf
echo "Cross-compile architecture packages added"

#Make the kernel and apply it to existing rootfs
$VAGRANTPATH/build_kernel.sh $VAGRANTPATH $KERNELVER

