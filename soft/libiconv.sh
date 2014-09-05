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

soft_version="1.14"

rm -rf libiconv-${soft_version}
if [ ! -f libiconv-${soft_version}.tar.gz ]; then
    wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-${soft_version}.tar.gz
fi
tar -zxvf libiconv-${soft_version}.tar.gz
cd libiconv-${soft_version}

./configure
make
make install

cd ..
rm -rf libiconv-${soft_version}
# rm -f libiconv-${soft_version}.tar.gz
