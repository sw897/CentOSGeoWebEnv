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

soft_version="4.8.0"

rm -rf proj-${soft_version}
if [ ! -f proj-${soft_version}.tar.gz ]; then
    wget http://download.osgeo.org/proj/proj-${soft_version}.tar.gz
fi

tar -zxvf proj-${soft_version}.tar.gz
cd proj-${soft_version}

./configure
make
make install

cd ..
rm -rf proj-${soft_version}
# rm -f proj-${soft_version}.tar.gz
