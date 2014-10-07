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


rm -rf mongo-cxx-driver-legacy-0.0-26compat-2.6.4.tar.gz
if [ ! -f legacy-0.0-26compat-2.6.4.tar.gz ]; then
    wget https://github.com/mongodb/mongo-cxx-driver/archive/legacy-0.0-26compat-2.6.4.tar.gz
fi

tar -zxvf legacy-0.0-26compat-2.6.4.tar.gz
cd mongo-cxx-driver-legacy-0.0-26compat-2.6.4

yum install -y scons
scons --use-system-boost --full --sharedclient install-mongoclient

cd ..
rm -rf mongo-cxx-driver-legacy-0.0-26compat-2.6.4
