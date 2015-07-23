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

pgsql_path="/usr/local/pgsql"
pgsql_data="/mydata/pgsql_data"
postgis_ver="postgis-2.1"
soft_version="2.1.8"

rm -rf postgis-${soft_version}
if [ ! -f postgis-${soft_version}.tar.gz ]; then
    wget http://download.osgeo.org/postgis/source/postgis-${soft_version}.tar.gz
fi

tar -zxvf postgis-${soft_version}.tar.gz
cd postgis-${soft_version}

./configure --with-pgconfig=/usr/local/pgsql/bin/pg_config
make
make  install

#create db
${pgsql_path}/bin/createdb -U postgres -E UTF8 --template=template0 postgis
${pgsql_path}/bin/createlang -U postgres plpgsql postgis
${pgsql_path}/bin/psql -U postgres -d postgis -c "CREATE EXTENSION postgis;"
chmod -R 0700 ${pgsql_data}

cd ..
rm -rf postgis-${soft_version}
# rm -f postgis-${soft_version}.tar.gz
