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

python_version="2.7"
gdal_version="1.11.0"

sys_python_packages="/usr/local/lib/python${python_version}/site-packages"
env_python_packages=${python_env_root}/lib/python${python_version}/site-packages/

virtualenv-${python_version} --no-site-packages ${python_env_root}
source ${python_env_root}/bin/activate

# install_func "pysqlite"    "${env_python_packages}/pysqlite2"    "./soft/pysqlite.sh"
pysqlite_version="2.6.3"
rm -rf pysqlite-${soft_version}
if [ ! -f pysqlite-${pysqlite_version}.tar.gz ]; then
    wget https://pypi.python.org/packages/source/p/pysqlite/pysqlite-${pysqlite_version}.tar.gz
fi
tar -zxvf pysqlite-${pysqlite_version}.tar.gz
if [ -e "./pysqlite_setup.cfg" ]; then
    cat pysqlite_setup.cfg > pysqlite-${pysqlite_version}/setup.cfg
elif [ -e "./soft/pysqlite_setup.cfg" ]; then
    cat ./soft/pysqlite_setup.cfg > pysqlite-${pysqlite_version}/setup.cfg
fi
cd pysqlite-${pysqlite_version}
python${python_version} setup.py build
python${python_version} setup.py install
cd ..
rm -rf pysqlite-${pysqlite_version}

pip${python_version} install simplejson
pip${python_version} install lxml
pip${python_version} install pillow
pip${python_version} install pyyaml
pip${python_version} install eventlet
pip${python_version} install shapely
pip${python_version} install numpy

pip${python_version} install -v django==1.6.6
pip${python_version} install south
pip${python_version} install six

pip${python_version} install uwsgi

# gdal
# mv -s ${sys_python_packages}/GDAL-${gdal_version}-py${python_version}-linux-x86_64.egg/EGG-INFO ${sys_python_packages}/GDAL-${gdal_version}-py${python_version}-linux-x86_64.egg/GDAL-${gdal_version}-py${python_version}.egg-info
ln -s ${sys_python_packages}/GDAL-${gdal_version}-py${python_version}-linux-x86_64.egg/osgeo ${env_python_packages}

# mapnik
ln -s ${sys_python_packages}/mapnik ${env_python_packages}

deactivate
