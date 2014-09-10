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

rm -rf boost_1_56_0
if [ ! -f boost_1_56_0.tar.gz ]; then
    wget http://jaist.dl.sourceforge.net/project/boost/boost/1.56.0/boost_1_56_0.tar.gz
fi
tar -zxvf boost_1_56_0.tar.gz
cd boost_1_56_0

./bootstrap.sh
./bjam -sTOOLS=gcc  install

if [ -e "../user-config.jam" ]; then
    cp ../user-config.jam > ./user-config.jam
elif [ -e "../soft/user-config.jam" ]; then
    cp ../soft/user-config.jam > ./user-config.jam
fi

bjam --with-python -a -j2 --ignore-site-config --user-config=user-config.jam toolset=gcc stage -d2
cp stage/lib/libboost_python.so* /usr/local/lib

cd ..
rm -rf boost_1_56_0
# rm -f boost_1_56_0.tar.gz
