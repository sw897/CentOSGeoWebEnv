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

if [ ! -d mapnik ]; then
    git clone git://github.com/mapnik/mapnik.git mapnik
else
    git pull
fi

cd mapnik
./configure
make
make install
