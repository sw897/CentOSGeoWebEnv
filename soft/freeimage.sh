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

soft_version="3.17.0"
soft_version2="3170"

rm -rf freeimage-${soft_version}
if [ ! -f freeimage-${soft_version}.tar.gz ]; then
    wget http://jaist.dl.sourceforge.net/project/freeimage/Source%20Distribution/${soft_version}/FreeImage${soft_version2}.zip
fi

unzip FreeImage${soft_version2}.zip
cd FreeImage

make
make install

cd ..
rm -rf FreeImage
