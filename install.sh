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

if [ -d "/usr/lib64" ]; then
    ln -s /usr/lib64/* /usr/lib/
fi

ldconfig

yum update -y

install_func_online "gcc gcc-c++ readline-devel autoconf automake make cmake libtool patch flex m4"

install_func_online "wget git"

install_func_online "bzip2-devel zlib-devel"

install_func_online "ncurses-devel ntp openssl"

install_func_online "libjpeg-devel libpng-devel giflib-devel libtiff-devel"

install_func_online "libxml2-devel libxslt-devel"

install_func_online "libyaml libyaml-devel"

install_func_online "libicu-devel freetype-devel glib2-devel gd gd-devel libevent-devel libtool-ltdl-devel libmcrypt-devel"

install_func_online "curl libcurl-devel"

install_func_online "sqlite sqlite-devel"

install_func "Boost" "/usr/local/lib/libboost_filesystem.so" "./soft/boost.sh"

install_func "harfBuzz" "/usr/local/lib/libharfbuzz.so" "./soft/harfbuzz.sh"

update_ldconfig

# mysql
$kill_all mysqld
install_func_online "mysql mysql-devel mysql-server"
mysqldatadir=${data_root}/mysql_data
if [ ! -d "$mysqldatadir" ]; then
    mkdir -p "$mysqldatadir";
fi
mysql_install_db --datadir=${mysqldatadir}
service mysqld restart
#service mysqld stop

# pgsql
install_func "PgSQL"    "/usr/local/pgsql/bin/createdb"    "./soft/pgsql.sh"

update_ldconfig

# python27
install_func_online "python python-devel python-pip"

# nginx
install_func_online "nginx"

# osgeo
install_func "Proj4"    "/usr/local/lib/libproj.so"    "./soft/proj.sh"
install_func "Geos"    "/usr/local/bin/geos-config"    "./soft/geos.sh"
install_func_online "json-c-devel xerces-c-devel expat-devel freexl-devel libaio-devel"
update_ldconfig

install_func "Spatialite"    "/usr/local/lib/libspatialite.so"    "./soft/spatialite.sh"
install_func "Gdal"    "/usr/local/gdal/lib/libgdal.so"    "./soft/gdal.sh"
install_func "PostGIS"    "/usr/local/pgsql/bin/shp2pgsql"    "./soft/postgis.sh"
# mapnik
install_func "Mapnik"    "/usr/local/lib/mapnik"    "./soft/mapnik.sh"

echo 'export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib:/lib"' >> "/etc/profile";
. "/etc/profile";

# set start cmd
start_script_file="/etc/rc.local"
if [ `grep -l "exit 0"    "$start_script_file"` ]; then
    str_replace    "exit 0/#exit 0"    "$start_script_file";
fi

# python 3th party
pip install virtualenv
virtualenv --no-site-packages ${python_env_root}
source ${python_env_root}/bin/activate

install_func "pysqlite"    "${python_env_root}/lib/python2.6/site-packages/pysqlite2"    "./soft/pysqlite.sh"
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

# mapnik

deactivate

./copyright.sh
rm -rf /tmp/nmgeowebenv_install_status.txt

# cd ~
