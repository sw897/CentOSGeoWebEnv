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

soft_version="3.4.2"

rm -rf geos-${soft_version}
if [ ! -f geos-${soft_version}.tar.bz2 ]; then
    wget http://download.osgeo.org/geos/geos-${soft_version}.tar.bz2
fi
tar -jxvf geos-${soft_version}.tar.bz2
cd geos-${soft_version}

# wget http://trac.osgeo.org/geos/raw-attachment/ticket/535/geos-535.patch
# wget http://trac.osgeo.org/geos/raw-attachment/ticket/535/geos-535-makefile-in.patch
# patch -p0 < geos-535.patch
# patch -p0 < geos-535-makefile-in.patch

./configure
make
make install

cd ..
rm -rf geos-${soft_version}
