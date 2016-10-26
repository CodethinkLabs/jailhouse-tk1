
DEV_HOME=/home/vagrant
NVD=/home/vagrant/install       
LD_LIBRARY_PATH=$NVD/lib
PKG_CONFIG_PATH=$NVD/lib/pkgconfig/:$NVD/share/pkgconfig/:/usr/lib/arm-linux-gnueabihf/pkgconfig/
ACLOCAL="aclocal -I $NVD/share/aclocal"

DRM_SETTINGS="--disable-cairo-tests \
--disable-intel \
--disable-radeon \
--disable-vmwgfx \
--disable-freedreno \
--disable-valgrind \
--disable-amdgpu \
--enable-static"

MESA_SETTINGS="--without-dri-drivers \
--with-gallium-drivers=nouveau \
--enable-gbm \
--enable-egl \
--with-egl-platforms=drm,x11,wayland \
--enable-gles1 \
--enable-gles2 \
--enable-opengl \
--enable-osmesa \
--enable-shared-glapi \
--enable-dri3 \
--enable-glx \
--enable-glx-tls"

HOST=arm-linux-gnueabihf

export DEV_HOME NVD LD_LIBRARY_PATH PKG_CONFIG_PATH ACLOCAL HOST DRM_SETTINGS MESA_SETTINGS
