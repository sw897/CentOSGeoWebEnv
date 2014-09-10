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

if [ -e "../inc.sh" ]; then
    . "../inc.sh"
elif [ -e "./inc.sh" ]; then
    . "./inc.sh"
fi

rm -rf boost_1_56_0
if [ ! -f boost_1_56_0.tar.gz ]; then
    wget http://jaist.dl.sourceforge.net/project/boost/boost/1.56.0/boost_1_56_0.tar.gz
fi
tar -zxvf boost_1_56_0.tar.gz
cd boost_1_56_0

source ${python_env_root}/bin/activate
./bootstrap.sh
./bjam -sTOOLS=gcc install
deactivate

cd ..
rm -rf boost_1_56_0
# rm -f boost_1_56_0.tar.gz
