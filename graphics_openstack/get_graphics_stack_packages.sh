#!/bin/bash

#We need to use wayland scanner from native libwayland-dev (from ubuntu disto) but the armhf libaries from libwayland-dev:armhf
wget http://launchpadlibrarian.net/188497486/libwayland-dev_1.6.0-2_amd64.deb
mkdir libwayland-dev_amd64
dpkg-deb -x libwayland-dev_1.6.0-2_amd64.deb libwayland-dev_amd64/
cp libwayland-dev_amd64/usr/bin/wayland-scanner /usr/bin/

#Clone the relevant libraries
git clone git://anongit.freedesktop.org/xcb/pthread-stubs
git clone git://anongit.freedesktop.org/mesa/drm
git clone --depth 1 --branch "mesa-12.0.2" git://anongit.freedesktop.org/mesa/mesa
git clone --branch "gk20a" https://github.com/Gnurou/kmscube.git

