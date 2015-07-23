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

soft_version="1.0.3"
rm -rf mongo-cxx-driver-legacy-${soft_version}.tar.gz
if [ ! -f mongo-cxx-driver-legacy-${soft_version}.tar.gz ]; then
    wget https://github.com/mongodb/mongo-cxx-driver/archive/legacy-${soft_version}.tar.gz
fi

tar -zxvf mongo-cxx-driver-legacy-${soft_version}.tar.gz
cd mongo-cxx-driver-legacy-${soft_version}

yum install -y scons
scons --use-system-boost --full --sharedclient install-mongoclient

cd ..
rm -rf mongo-cxx-driver-legacy-${soft_version}
