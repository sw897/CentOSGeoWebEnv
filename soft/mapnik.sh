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

git checkout v3.0.0
#git checkout 1c56214bbbcf3dc5d3e9bed1810d8279ecfad9ec

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
