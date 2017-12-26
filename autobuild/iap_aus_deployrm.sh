#!/bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

cd $buildhome/iap_aus_rm/$1/package/
echo 'open 10.1.198.61
user clouderauser clouderauser
cd /home/clouderauser/dataprocess/ftp-xml_dataprocess/dataprocess/plugin/
#cd /home/clouderauser/dataprocess/ftp-xml-rm_dataprocess/dataprocess/plugin/
bin
put *.jar
' |ftp -n
sleep 3
