#!/bin/sh

mysql_user='mysql'

datadir=/mydata/mysql_data
if [ ! -d '/mydata/mysql_data' ]; then
    mkdir -p ${datadir}
fi

chown -R ${mysql_user} ${datadir}
chmod -R 2770 ${datadir}

mysql_install_db --user=root --datadir=${datadir};
echo

chown -R ${mysql_user}:${mysql_user} ${datadir}
chmod -R 2770 $datadir

mysqld_safe --user=${mysql_user} --datadir=${datadir} &
echo

if [ `ps -Af | grep "mysqld_safe" | grep -vc 'grep'` != '0' ]; then
    echo "MySQL was restored successfully"
else
    echo "MySQL was restored failed"
fi
