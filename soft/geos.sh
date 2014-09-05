#!/bin/sh
#
# ******************************************************************************
# Software:     CentOSGeoWebEnv
# Author:       sw
# Website:      www.chinamap.me
# Email:        sunwei.r@gmail.com
# ------------------------------------++++
# Thank you for choosing CentOSGeoWebEnv!
# ******************************************************************************
#

soft_version="3.4.2"

rm -rf geos-${soft_version}
if [ ! -f geos-${soft_version}.tar.bz2 ]; then
    wget http://download.osgeo.org/geos/geos-${soft_version}.tar.bz2
fi
tar -jxvf geos-${soft_version}.tar.bz2
cd geos-${soft_version}

./configure
make
make install

cd ..
rm -rf geos-${soft_version}
# rm -f geos-${soft_version}.tar.bz2
