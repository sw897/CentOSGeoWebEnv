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

if [ -e "./inc.sh" ]; then
    . "./inc.sh"
fi

#  install Start
if [ "${linux_type}" != 'RedHat' ]; then
    showmsg "您的系统不能安装 CentOSGeoWebEnv，谢谢您的关注！"    "Sorry! This system can't install CentOSGeoWebEnv."    $color_red    $color_white
    exit;
fi

echo 'Please wait to lock in time......'
if [ -f "/usr/bin/ntpdate" ] || [ -f "/usr/sbin/ntpdate" ] || [ -f "/usr/local/bin/ntpdate" ]; then
    ntpdate time.windows.com
fi
runtime 'start';

datetime=`date +"%Y%m%d"`
release_date=$(($release_date-1));#wrong date time, But can be used.
if test $datetime -lt $release_date; then
    date ${release_md}2359${release_y}
fi

chmod 755 ./*

echo
echo
echo "Starting to install $geowebenv_version, Please wait..."
echo
echo

sleep $sleep_time

ulimit -v unlimited

export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib:/lib"

if [ ! `grep -l '/usr/local/lib'    '/etc/ld.so.conf'` ]; then
    echo "/usr/local/lib" >> /etc/ld.so.conf
fi

if [ -d "/usr/lib64" ] && [ ! `grep -l '/usr/lib64'    '/etc/ld.so.conf'` ]; then
    echo "/usr/lib64" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/lib'    '/etc/ld.so.conf'` ]; then
    echo "/usr/lib" >> /etc/ld.so.conf
fi

if [ ! `grep -l "/lib"    '/etc/ld.so.conf'` ]; then
    echo "/lib" >> /etc/ld.so.conf
fi

ldconfig

yum update -y

install_func_online "gcc gcc-c++ readline-devel autoconf automake make cmake libtool patch flex m4"

install_func_online "wget git"

install_func_online "bzip2-devel zlib-devel"

install_func_online "ncurses-devel ntp openssl"

install_func_online_plus "openssl-devel"

install_func_online "libicu-devel libevent-devel libtool-ltdl-devel libmcrypt-devel"

install_func_online "libjpeg-turbo-devel libpng-devel giflib-devel libtiff-devel"

install_func_online "freetype-devel gd gd-devel glib2-devel cairo-devel"

install_func_online "libxml2-devel libxslt-devel"

install_func_online "libyaml libyaml-devel"

install_func_online "curl libcurl-devel"

install_func "devtoolset" "/opt/rh/devtoolset-2/root/usr/bin/gcc" "./soft/devtoolset.sh"

# install_func_online "sqlite sqlite-devel"
install_func "sqlite" "/usr/local/lib/libsqlite3.so" "./soft/sqlite.sh"

ldconfig

# python27
install_func "python" "/usr/local/bin/python2.7" "./soft/python.sh"

install_func "boost" "/usr/local/lib/libboost_filesystem.so" "./soft/boost.sh"

install_func "harfBuzz" "/usr/local/lib/libharfbuzz.so" "./soft/harfbuzz.sh"

ldconfig

# mysql
install_func_online "mysql mysql-server"
mysqldatadir=${data_root}/mysql_data
if [ ! -d "$mysqldatadir" ]; then
    mkdir -p "$mysqldatadir";
    $kill_all mysqld
    mysql_install_db --datadir=${mysqldatadir}
    service mysqld restart
    #service mysqld stop
fi

# pgsql
install_func "pgsql"    "/usr/local/pgsql/bin/createdb"    "./soft/pgsql.sh"

ldconfig

# nginx
install_func_online "nginx"

# osgeo
install_func "proj4"    "/usr/local/lib/libproj.so"    "./soft/proj.sh"
install_func "geos"    "/usr/local/bin/geos-config"    "./soft/geos.sh"

install_func_online "json-c-devel xerces-c-devel expat-devel freexl-devel libaio-devel"
ldconfig

install_func "spatialite"    "/usr/local/lib/libspatialite.so"    "./soft/spatialite.sh"
install_func "gdal"    "/usr/local/lib/libgdal.so"    "./soft/gdal.sh"
install_func "postgis"    "/usr/local/pgsql/bin/shp2pgsql"    "./soft/postgis.sh"
# mapnik
install_func "mapnik"    "/usr/local/lib/libmapnik.so"    "./soft/mapnik.sh"

if [ ! `grep -l 'export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib:/lib"'    '/etc/profile'` ]; then
    echo 'export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib:/lib"' >> "/etc/profile";
    . "/etc/profile";
fi


# set start cmd
start_script_file="/etc/rc.local"
if [ `grep -l "exit 0"    "$start_script_file"` ]; then
    str_replace    "exit 0/#exit 0"    "$start_script_file";
fi

# python virtual env
install_func "python_env" "${python_env_root}/lib/python2.7/site-packages/pysqlite2" "./soft/python-env.sh"

./copyright.sh
rm -rf /tmp/nmgeowebenv_install_status.txt

# cd ~
