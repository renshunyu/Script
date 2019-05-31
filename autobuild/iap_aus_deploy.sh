#!/bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

cd $buildhome/iap_aus/$1/package/
echo 'open 10.1.198.60
user aus aus
cd /home/aus/dataprocess/tcp-xml_dataprocess/dataprocess/plugin
bin
put *.jar
' |ftp -n
sleep 3
