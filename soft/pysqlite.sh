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

soft_version="2.6.3"

rm -rf pysqlite-${soft_version}
if [ ! -f pysqlite-${soft_version}.tar.gz ]; then
    wget https://pypi.python.org/packages/source/p/pysqlite/pysqlite-${soft_version}.tar.gz
fi
tar -zxvf pysqlite-${soft_version}.tar.gz
cat pysqlite_setup.cfg > pysqlite-${soft_version}/setup.cfg
cd pysqlite-${soft_version}

python2.7 setup.py build
python2.7 setup.py install

cd ..
rm -rf pysqlite-${soft_version}
# rm -f pysqlite-${soft_version}.tar.gz
