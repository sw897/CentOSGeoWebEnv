#!/bin/sh
#
# ******************************************************************************
# Software:     CentOSGeoWebEnv
# Author:       mapdb
# Website:      www.mapdb.cn
# Email:        mapdb2014@gmail.com
# ------------------------------------++++
# Thank you for choosing CentOSGeoWebEnv!
# ******************************************************************************
#

soft_version="3.16.0"

rm -rf freeimage-${soft_version}
if [ ! -f freeimage-${soft_version}.tar.gz ]; then
    wget http://jaist.dl.sourceforge.net/project/freeimage/Source%20Distribution/3.16.0/FreeImage3160.zip
fi

unzip FreeImage3160.zip
cd FreeImage

make
make install

cd ..
rm -rf FreeImage
