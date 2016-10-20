#!/bin/bash
#Top level build of the kernel and jailhouse within a Vagrant VM, installing cross-compiler toolchain as well.

sudo -i
VAGRANTPATH=$1
KERNELVER=$2

$VAGRANTPATH/cross_compile_setup.sh

#Make the kernel and jailhouse and apply it to existing rootfs
mkdir -p $VAGRANTPATH/rootfs
$VAGRANTPATH/build_kernel.sh $VAGRANTPATH $KERNELVER rootfs
cd /home/vagrant

if [ -d _linux_out ]  &&  [ -d $VAGRANTPATH/rootfs ]
then 
    $VAGRANTPATH/build_jailhouse.sh $VAGRANTPATH /home/vagrant/_linux_out rootfs 
else
    echo "_linux_out and/or rootfs directory not found! Aborting jailhouse build."
    exit 1
fi

#Copy the linux-stable dir to shared folder, needed for future jailhouse compilations
cp -ar /home/vagrant/linux-stable $VAGRANTPATH
