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

soft_version="0.12-20140410"

rm -rf json-c-${soft_version}
if [ ! -f json-c-${soft_version}.tar.gz ]; then
    wget https://github.com/json-c/json-c/archive/json-c-${soft_version}.tar.gz
fi

tar -zxvf json-c-${soft_version}.tar.gz
cd json-c-${soft_version}

./configure
make
make install

cd ..
rm -rf json-c-${soft_version}
# rm -f json-c-${soft_version}.tar.gz
