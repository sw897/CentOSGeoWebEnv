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

postgis_ver="postgis-2.1"
soft_root="/usr/local"
pgsql_data="/mydata/pgsql_data"
soft_version="2.1.3"

rm -rf postgis-${soft_version}
if [ ! -f postgis-${soft_version}.tar.gz ]; then
    wget http://download.osgeo.org/postgis/source/postgis-${soft_version}.tar.gz
fi

tar -zxvf postgis-${soft_version}.tar.gz
cd postgis-${soft_version}

./configure
make
make  install

#create db
createdb -U postgres -E UTF8 postgis
createlang plpgsql -U postgres postgis
psql -U postgres -d postgis -f /usr/local/share/contrib/${postgis_ver}/postgis.sql
psql -U postgres -d postgis -f /usr/local/share/contrib/${postgis_ver}/spatial_ref_sys.sql
chmod -R 0700 ${pgsql_data}

cd ..
rm -rf postgis-${soft_version}
# rm -f postgis-${soft_version}.tar.gz
