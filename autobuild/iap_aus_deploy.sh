#!/bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

cd $buildhome/iap_aus/$1/package/
echo 'open 10.1.198.61
user clouderauser clouderauser
cd /home/clouderauser/dataprocess/tcp-xml_dataprocess/dataprocess/plugin/
bin
put *.jar
' |ftp -n
sleep 3
