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

if [ -e "../inc.sh" ]; then
    . "../inc.sh"
elif [ -e "./inc.sh" ]; then
    . "./inc.sh"
fi

soft_version="2.7.9"
python_version="2.7"

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

python${python_version} ez_setup.py
easy_install-${python_version} pip

pip${python_version} install virtualenv
