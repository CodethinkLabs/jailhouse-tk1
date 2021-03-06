#!/bin/bash

if [ "$EUID" -ne 0 ]
then echo "Please run as root"
            exit 1
fi

rm -rf Linux_for_Tegra linux-stable rootfs nouveau
vagrant destroy -f

cd graphics_openstack
vagrant destroy -f
cd ..

exit 0
