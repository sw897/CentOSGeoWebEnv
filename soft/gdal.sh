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

soft_version="1.10.1"

rm -rf gdal-${soft_version}
if [ ! -f gdal-${soft_version}.tar.gz ]; then
    wget http://download.osgeo.org/gdal/${soft_version}/gdal-${soft_version}.tar.gz
fi
tar -zxvf gdal-${soft_version}.tar.gz
cd gdal-${soft_version}

./configure \
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
python setup.py build
python setup.py install
cd ../..


cd ..
rm -rf gdal-${soft_version}
# rm -f gdal-${soft_version}.tar.gz
