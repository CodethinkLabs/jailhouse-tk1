#!/bin/bash
#Builds a linux kernel with configuration compatible for the TK1 in HYP mode
#And with the jailhouse hypervisor
#
#Jailhouse fix: https://github.com/siemens/jailhouse/blob/master/Documentation/setup-on-banana-pi-arm-board.md
#Compatible linux configuration: https://wiki.sel4.systems/Hardware/jetsontk1

if [ $# -ne 3 ]
then
   echo "Incorrect number of arguments supplied. STOP"
   exit 
fi
VAGRANTDIR=$1
KERNELVER=$2
KDIR=$3

#Install deps for linux kernel and clone at the specified $KERNELVER
sudo apt-get install -y libncurses5-dev gcc make git exuberant-ctags bc libssl-dev
git clone --branch $KERNELVER --depth 1 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

#Apply patches: config file to ensure kernel compatability with TK1 in HYP mode
#armksysms.c file is to export kernel symbol that is required for jailhouse operation
cd linux-stable
cp $VAGRANTDIR/kernel_config/.config .
cp $VAGRANTDIR/kernel_config/armksyms.c arch/arm/kernel/

#make the kernel
#Apply: zImage, dtb files, modules, firmware and header to a specified rootfs
make -j4 ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- -k

mkdir -p $VAGRANTDIR/$KDIR/boot
cp arch/arm/boot/zImage $VAGRANTDIR/$KDIR/boot/
cp arch/arm/boot/dts/*.dtb $VAGRANTDIR/$KDIR/boot/
make -j4 ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- INSTALL_MOD_PATH=$VAGRANTDIR/$KDIR modules_install
make -j4 ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- INSTALL_FW_PATH=$VAGRANTDIR/$KDIR/lib/firmware firmware_install
make -j4 ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- INSTALL_HDR_PATH=$VAGRANTDIR/$KDIR/usr headers_install

