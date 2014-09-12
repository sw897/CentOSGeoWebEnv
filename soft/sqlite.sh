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

rm -rf sqlite-autoconf-3080600
if [ ! -f sqlite-autoconf-3080600.tar.gz ]; then
    wget http://sqlite.org/2014/sqlite-autoconf-3080600.tar.gz
fi

tar -zxvf sqlite-autoconf-3080600.tar.gz
cd sqlite-autoconf-3080600

./configure
make
make install

cd ..
rm -rf sqlite-autoconf-3080600
