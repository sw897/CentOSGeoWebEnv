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

soft_version="9.3.5"
pgsql_data="/mydata/pgsql_data"

user_del='userdel';
user_add='useradd';
group_del='groupdel';
group_add='groupadd';

$user_del 1506
$user_del postgres
$group_del 1506
$group_del postgres
$group_add postgres -g 1506
$user_add postgres -u 1506 -g postgres -d /dev/null

$kill_all postgres
rm -rf postgresql-${soft_version}
# rm -f postgresql-${soft_version}.tar.bz2
if [ ! -f postgresql-${soft_version}.tar.bz2 ]; then
    wget http://ftp.postgresql.org/pub/source/v${soft_version}/postgresql-${soft_version}.tar.bz2
fi
tar -jxvf postgresql-${soft_version}.tar.bz2
cd postgresql-${soft_version}

./configure --with-python
make
make install

mkdir ${pgsql_data}
chown -R postgres:postgres  -U postgres
chmod -R 0700 /home/pgsql_data
if [ -f "${pgsql_data}/pgsql.log" ]; then
    rm -rf ${pgsql_data}*
fi
su postgres -c "initdb -U postgres -D ${pgsql_data}"
chmod -R 0700 ${pgsql_data}

echo '#' > ${pgsql_data}/pgsql.log;
chown postgres ${pgsql_data}/pgsql.log
su postgres -c "pg_ctl -U postgres -D ${pgsql_data} -l ${pgsql_data}/pgsql.log start"
chmod -R 0700 ${pgsql_data}
sleep 3;

createdb -T template0 -U postgres -E UTF8 newmap
chmod -R 0700 ${pgsql_data}

psql -U postgres -c "alter role postgres password 'postgres';"
chmod -R 0700 ${pgsql_data}

cd ..
cat pg_hba.conf > -U postgres/pg_hba.conf

rm -rf postgresql-${soft_version}
# rm -f postgresql-${soft_version}.tar.bz2
