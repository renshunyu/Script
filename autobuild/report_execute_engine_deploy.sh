#!/bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

cd $buildhome/report_execute_engine/target/
echo ftpstart
echo 'open 10.1.198.54
user clouderauser clouderauser
cd /home/clouderauser/report_execute_engine
bin
put report_execute_engine-1.0.tar.gz
' |ftp -n
sleep 3
