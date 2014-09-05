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

soft_version="4.2.0"

rm -rf libspatialite-${soft_version}
if [ ! -f libspatialite-${soft_version}.tar.gz ]; then
    wget http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-${soft_version}.tar.gz
fi
tar -zxvf libspatialite-${soft_version}.tar.gz
cd libspatialite-${soft_version}

./configure
make
make install

cd ..
rm -rf libspatialite-${soft_version}
# rm -f libspatialite-${soft_version}.tar.gz
