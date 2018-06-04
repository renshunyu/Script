#!/bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

cd $buildhome/iap_aus/$1/package/
echo 'open 10.1.198.61
user aiiap aiiap
cd /home/aiiap
bin
put *.jar
' |ftp -n
sleep 3
