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


if [ "`id -u`" != "0" ]; then
    echo "请用root用户安装 CentOSGeoWebEnv！"
    echo
    echo "Please use root user to install CentOSGeoWebEnv!"
    echo
    exit;
fi

geowebenv_version='CentOSGeoWebEnv 1.0'
release_y='2014'
release_md='0901'
release_date=${release_y}${release_md}

data_root='/mydata'
www_root="${data_root}/www"
python_env_root="${data_root}/env"

if [ ! -d "${data_root}" ]; then
    if [ ! -d '/mnt/data' ]; then
        mkdir /mnt/data
    fi
    ln -s /mnt/data ${data_root}
fi

if [ ! -d "${www_root}" ]; then
    mkdir -p "${www_root}";
fi

if [ ! -d "${python_env_root}" ]; then
    mkdir -p "${python_env_root}";
fi

color_cyan="[40;36m"
color_red="[40;31m"
color_yellow="[40;33m"
color_green="[40;32m"
color_white="[40;37m"

continue_install_string="was successfully installed! Continue..."
continue_install_string_cn="安装成功，继续安装$geowebenv_version"
stop_install_string="is not installed! Stop to install $geowebenv_version."
stop_install_string_cn="安装不成功！停止安装$geowebenv_version"

sleep_time=2;

enter2="\n\n";
enter4=${enter2}${enter2};
enter8=${enter4}${enter4};

system_hardware=`uname -m`;
uname=`uname`
server_name=`uname -n`;

user_del='userdel';
user_add='useradd';
group_del='groupdel';
group_add='groupadd';

if [ -f '/usr/bin/killall' ] || [ -f '/usr/sbin/killall' ]; then
    kill_all='killall';
else
    kill_all='pkill';
fi

if [ -d "/etc/apt" ] && [ -f "/usr/bin/dpkg" ]; then
    linux_type='Debian';
else
    linux_type='RedHat';
fi

linux_version_1=`head -1 /etc/issue`;
linux_version_2=`echo $linux_version_1|cut -c1-10`;

if [ `echo $linux_version_2 | grep -c 'CentOS'` = "1" ]; then
    linux_version='CentOS';
elif [ `echo $linux_version_2 | grep -c 'Red Hat'` = "1" -o `echo $linux_version_2 | grep -c 'RedHat'` = "1" ]; then
    linux_version='RedHat';
elif [ `echo $linux_version_2 | grep -c 'Debian'` = "1" ]; then
    linux_version='Debian';
elif [ `echo $linux_version_2 | grep -c 'Ubuntu'` = "1" ]; then
    linux_version='Ubuntu';
fi

root_group='root'
is_Linux='Yes'

if [ "$system_hardware" = 'x86_64' ]; then
    system_bit='64'
else
    system_bit='32'
fi


showmsg () {
    NO3_var=$3
    NO4_var=$4

    if [ ! "$NO3_var" ]; then
        NO3_var=$color_yellow
    fi

    if [ ! "$NO4_var" ]; then
        NO4_var=$color_white
    fi

    echo
    echo $NO3_var$1$NO4_var
    if [ "$2" ]; then
        echo $NO3_var$2$NO4_var
    fi
    echo
}

runtime () {
    if [ "$1" = 'start' ]; then
        start_time=`date +"%s"`
        echo ${start_time} > "/var/tmp/geowebenv_runtime"
        sleep 2
    else
        start_time=`cat /var/tmp/geowebenv_runtime`
        end_time=`date +"%s"`
        total_s=$(($end_time - $start_time))
        total_m=$(($total_s / 60))

        if test $total_s -lt 60; then
            time_cn="${total_s} 秒钟"
            time_en="${total_s} Seconds"
        else
            time_cn="${total_m} 分钟"
            time_en="${total_m} Minutes"
        fi

        if [ "$1" = 'end' ]; then
            echo "Install GeoWebEnv Runtime: ${time_cn}(${time_en})" > /var/tmp/geowebenv_runtime
            showmsg "总耗时：${time_cn}"     "Total runtime: ${time_en}"     $color_yellow    $color_white
        else
            showmsg "已耗时：${time_cn}"     "Runtime: ${time_en}"     $color_yellow    $color_white
        fi
    fi
}

install_func () {
    if [ ! -e $2 ]; then
        $3
    fi
    if [ ! -e $2 ]; then
        echo -e "$1 $stop_install_string" > /tmp/geowebenv_install_status.txt
        showmsg "$1 $stop_install_string_cn"    "$1 $stop_install_string"    $color_red    $color_white
        exit
    else
        echo -e "$1 $continue_install_string" > /tmp/geowebenv_install_status.txt
        echo -e $enter2
        showmsg "$1 $continue_install_string_cn"    "$1 $continue_install_string"    $color_green    $color_white
        echo -e $enter2
    fi

    runtime
    sleep $sleep_time
}

install_func_online () {
    for soft_name in $1; do
        if [ "${linux_type}" = 'Debian' ]; then
            if [ "`dpkg -l | grep ii | grep -c ${soft_name}`" -eq "0" ]; then
                apt-get -y install $soft_name;
            fi
        elif [ "${linux_type}" = 'RedHat' ]; then
            if [ "`yum list installed | grep -c ${soft_name}`" -eq "0" ]; then
                yum -y install $soft_name;
            fi
            if [ `rpm -qa | grep -c ${soft_name}` -eq "0" ]; then
                echo -e "$soft_name $stop_install_string" > /tmp/geowebenv_install_status.txt
                echo -e $enter2
                showmsg "$soft_name $stop_install_string_cn"    "$soft_name $stop_install_string"    $color_red    $color_white
                exit
            else
                echo -e "$soft_name $continue_install_string" > /tmp/geowebenv_install_status.txt
                echo -e $enter2
                showmsg "$soft_name $continue_install_string_cn"    "$soft_name $continue_install_string"    $color_green    $color_white
            fi
        fi
        echo -e $enter2
    done;
    echo -e $enter4
    runtime
    sleep $sleep_time
}

rm_soft () {
    rm -rf $1
    showmsg "$2 删除成功！"    "$2 was successfully deleted!"    $color_green $color_white
    sleep $sleep_time
}

update_ldconfig () {

    if [ `uname` = "Linux" ]; then
        ldconfig
    fi

    if [ -d "/usr/lib64" ]; then
        ln -s /usr/lib64/* /usr/lib/
    fi

    if [ -d "/usr/local/lib64" ]; then
        ln -s /usr/local/lib64/* /usr/local/lib/
    fi

    if [ `uname` = "Linux" ]; then
        ldconfig
    fi

}

# 1. s/r
# 2. file
str_replace () {
    if [ `uname` = 'Linux' ]; then
        sed -i "s/$1/g" $2
    else
        sed "s/$1/g" $2 > ${2}.bak
        sed "s/------------search--------------/------------replace--------------/g" ${2}.bak > ${2}
    fi
}


###
