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


if [ ! -d mapnik ]; then
    git clone git://github.com/mapnik/mapnik.git mapnik
    cd mapnik
else
    cd mapnik
    git pull
fi
git checkout 2.3.x
#git checkout 648dea63ac6600529aab94e4807bc45992af2061

#`scl enable devtoolset-2 bash`

make clean

PYTHON=python2.7 ./configure \
PG_CONFIG=/usr/local/pgsql/bin/pg_config \
INPUT_PLUGINS=raster,shape,sqlite,postgis,ogr,gdal

# CC=/opt/rh/devtoolset-2/root/usr/bin/gcc \
# CXX=/opt/rh/devtoolset-2/root/usr/bin/g++ \
# CAIRO=False \

make PYTHON=python2.7
make install
