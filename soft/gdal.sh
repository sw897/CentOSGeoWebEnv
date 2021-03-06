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

soft_version="2.0.0"

rm -rf gdal-${soft_version}
if [ ! -f gdal-${soft_version}.tar.gz ]; then
    wget http://download.osgeo.org/gdal/${soft_version}/gdal-${soft_version}.tar.gz
fi
tar -zxvf gdal-${soft_version}.tar.gz
cd gdal-${soft_version}

./configure \
--with-pg=/usr/local/pgsql/bin/pg_config \
--with-sqlite3=/usr/local \
--with-grass=no \
--with-gta=no \
--with-libtiff=internal \
--with-geotiff=internal \
--with-gif=internal \
--with-odbc=no \
--with-sde=no \
--with-opencl=no \
--with-java=no

make
make install

# 单独编译python
cd swig/python
python2.7 setup.py build
python2.7 setup.py install
cd ../..


cd ..
rm -rf gdal-${soft_version}
# rm -f gdal-${soft_version}.tar.gz
