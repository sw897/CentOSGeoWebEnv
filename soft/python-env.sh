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

python_version="2.6"
gdal_version="1.11.0"

pip install virtualenv
virtualenv --no-site-packages ${python_env_root}

sys_python_packages="/usr/lib64/python${python_version}/site-packages"
env_python_packages=${python_env_root}/lib/python${python_version}/site-packages/

source ${python_env_root}/bin/activate

install_func "pysqlite"    "${env_python_packages}/pysqlite2"    "./soft/pysqlite.sh"
pip install simplejson
pip install lxml
pip install pillow
pip install pyyaml
pip install eventlet
pip install shapely
pip install numpy

pip install django
pip install south
pip install six
pip install tornado

# gdal
# mv -s ${sys_python_packages}/GDAL-${gdal_version}-py${python_version}-linux-x86_64.egg/EGG-INFO ${sys_python_packages}/GDAL-${gdal_version}-py${python_version}-linux-x86_64.egg/GDAL-${gdal_version}-py${python_version}.egg-info
ln -s ${sys_python_packages}/GDAL-${gdal_version}-py${python_version}-linux-x86_64.egg/osgeo ${env_python_packages}

# mapnik
ln -s ${sys_python_packages}/mapnik ${env_python_packages}

deactivate
