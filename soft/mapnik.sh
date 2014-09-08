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

if [ ! -d mapnik ]; then
    git clone git://github.com/mapnik/mapnik.git mapnik
    cd mapnik
else
    cd mapnik
    git pull
fi

./configure \
CC=/opt/rh/devtoolset-2/root/usr/bin/gcc \
CXX=/opt/rh/devtoolset-2/root/usr/bin/g++ \
PG_CONFIG=/usr/local/pgsql/bin/pg_config \
CAIRO=False \
INPUT_PLUGINS=raster,shape,sqlite,postgis,ogr,gdal

make
make install
