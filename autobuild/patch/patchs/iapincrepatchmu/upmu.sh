#!/bin/sh
export iapdir='/home/aiuap/aiuap30/tomcat_iap_increment/webapps/iap'
echo '����.'

result(){
        if [ ! $1 = 0 ]; then
        echo "iap����ʧ��!"
        exit 1
        fi
}

if [ ! -d $iapdir ]; then
    echo "$iapdir  ������,����ʧ��!"
    exit 1
fi


if [ $? = 0 ]; then
    echo "���³ɹ�!������iap!"
else
    echo "iap����ʧ��!"
    exit 1
fi

exit 0
