#!/bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

cd $buildhome/iap_aus/$1/package/
#echo 'open 10.1.198.60
echo 'open 10.1.198.54
user sdc_aus sdc_aus
cd /home/sdc_aus/dataprocess/ftp-xml_dataprocess/dataprocess/plugin
bin
put *.jar
' |ftp -n
sleep 3
