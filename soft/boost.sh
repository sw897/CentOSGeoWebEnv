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

boost_version="1_58_0"
boost_version2="1.58.0"
rm -rf boost_${boost_version}
if [ ! -f boost_${boost_version}.tar.gz ]; then
    wget http://jaist.dl.sourceforge.net/project/boost/boost/${boost_version2}/boost_${boost_version}.tar.gz
fi
tar -zxvf boost_${boost_version}.tar.gz
cd boost_${boost_version}

./bootstrap.sh
./bjam -sTOOLS=gcc  install

if [ -e "../user-config.jam" ]; then
    cp ../user-config.jam .
elif [ -e "../soft/user-config.jam" ]; then
    cp ../soft/user-config.jam .
fi

./bjam --with-python -a -j2 --ignore-site-config --user-config=user-config.jam toolset=gcc stage -d2
cp -f stage/lib/libboost_python.so* /usr/local/lib

cd ..
rm -rf boost_${boost_version}
# rm -f boost_${boost_version}.tar.gz
