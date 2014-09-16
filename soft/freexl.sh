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

soft_version="1.0.0g"

rm -rf freexl-${soft_version}
if [ ! -f freexl-${soft_version}.tar.gz ]; then
    wget http://www.gaia-gis.it/gaia-sins/freexl-${soft_version}.tar.gz
fi

tar -zxvf freexl-${soft_version}.tar.gz
cd freexl-${soft_version}

./configure
make
make install

cd ..
rm -rf freexl-${soft_version}
# rm -f freexl-${soft_version}.tar.gz
