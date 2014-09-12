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

# libspatialite
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

# # spatialite-tools
# rm -rf spatialite-tools-${soft_version}
# if [ ! -f spatialite-tools-${soft_version}.tar.gz ]; then
#     wget http://www.gaia-gis.it/gaia-sins/spatialite-tools-sources/spatialite-tools-${soft_version}.tar.gz
# fi
# tar -zxvf spatialite-tools-${soft_version}.tar.gz
# cd spatialite-tools-${soft_version}
#
# ./configure
# make
# make install
#
# cd ..
# rm -rf spatialite-tools-${soft_version}
