#!/bin/bash
#Top level build of the kernel and jailhouse within a Vagrant VM, installing cross-compiler toolchain as well.

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

#Make the kernel and jailhouse and apply it to existing rootfs
mkdir -p $VAGRANTPATH/rootfs
$VAGRANTPATH/build_kernel.sh $VAGRANTPATH $KERNELVER rootfs
cd /home/vagrant

if [ -d linux-stable ]  &&  [ -d $VAGRANTPATH/rootfs ]
then 
    $VAGRANTPATH/build_jailhouse.sh $VAGRANTPATH /home/vagrant/linux-stable rootfs 
else
    echo "linux-stable and/or rootfs directory not found! Aborting jailhouse build."
    exit 1
fi

#Copy the linux-stable dir to shared folder, needed for future jailhouse compilations
cp -ar /home/vagrant/linux-stable $VAGRANTPATH
