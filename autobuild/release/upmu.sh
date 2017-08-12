#!/bin/sh
export iapdir='/home/aiuap/aiuap30/tomcat_iap_increment/webapps/iap'
echo '补丁.'

result(){
        if [ ! $1 = 0 ]; then
        echo "iap更新失败!"
        exit 1
        fi
}

if [ ! -d $iapdir ]; then
    echo "$iapdir  不存在,更新失败!"
    exit 1
fi


if [ $? = 0 ]; then
    echo "更新成功!请重启iap!"
else
    echo "iap更新失败!"
    exit 1
fi

exit 0
