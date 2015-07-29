#!/bin/sh

db_name="postgis_wf"
shp_file="wfshp"
srid=4326
su postgres -c "createdb -U postgres -E UTF-8 --template=template0 $db_name"
su postgres -c "psql -U postgres -D $db_name -c \"CREATE EXTENSION postgis;\""
shp2pgsql -g the_geom -s ${srid} -W GB18030 ${shp_file}.shp ${shp_file}>${shp_file}.sql
su postgres -c "psql -U postgres -D $db_name -f ${shp_file}.sql"
