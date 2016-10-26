#!/bin/bash
#Setup of the cross-compiler toolchain on a debian system

#Add the debian cross-toolchain repository
apt-get install -y curl git
echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/crosstools.list
curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | sudo apt-key add -

#Install the cross-compiler architecture
sudo dpkg --add-architecture armhf
sudo apt-get update
apt-get install -y  crossbuild-essential-armhf
echo "Cross-compile architecture packages added"
