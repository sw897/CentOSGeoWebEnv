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

soft_version="2"

if [ ! -f /etc/yum.repos.d/devtools-2.repo ]; then
    wget http://people.centos.org/tru/devtools-2/devtools-2.repo -P /etc/yum.repos.d
    echo "enabled=1" >> /etc/yum.repos.d/devtools-2.repo
fi

yum install --enablerepo=centosplus -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++

export PATH="/opt/rh/devtoolset-2/root/usr/bin${PATH:+:${PATH}}"

if [ ! `grep -l 'export PATH="/opt/rh/devtoolset-2/root/usr/bin${PATH:+:${PATH}}"'    '/etc/profile'` ]; then
    echo 'export PATH="/opt/rh/devtoolset-2/root/usr/bin${PATH:+:${PATH}}"' >> "/etc/profile";
    . "/etc/profile";
fi
