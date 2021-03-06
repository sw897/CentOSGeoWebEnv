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

soft_version="0.9.41"

rm -rf harfbuzz-${soft_version}
if [ ! -f harfbuzz-${soft_version}.tar.bz2 ]; then
    wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${soft_version}.tar.bz2
fi
tar -jxvf harfbuzz-${soft_version}.tar.bz2
cd harfbuzz-${soft_version}

./configure
make
make install

cd ..
rm -rf harfbuzz-${soft_version}
# rm -f harfbuzz-${soft_version}.tar.bz2
