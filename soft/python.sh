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

soft_version="2.7.8"

rm -rf Python-${soft_version}
if [ ! -f Python-${soft_version}.tar.xz ]; then
    wget https://www.python.org/ftp/python/${soft_version}/Python-${soft_version}.tar.xz
fi

tar -xf Python-${soft_version}.tar.xz
cd Python-${soft_version}

./configure
make
make altinstall

cd ..
rm -rf Python-${soft_version}
# rm -f python-${soft_version}.tar.gz


if [ ! -f ez_setup.py ]; then
    wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
fi

python2.7 ez_setup.py
easy_install pip