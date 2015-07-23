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

soft_version="3080600"
rm -rf sqlite-autoconf-${soft_version}
if [ ! -f sqlite-autoconf-${soft_version}.tar.gz ]; then
    wget http://sqlite.org/2014/sqlite-autoconf-${soft_version}.tar.gz
fi

tar -zxvf sqlite-autoconf-${soft_version}.tar.gz
cd sqlite-autoconf-${soft_version}

./configure
make
make install

cd ..
rm -rf sqlite-autoconf-${soft_version}
