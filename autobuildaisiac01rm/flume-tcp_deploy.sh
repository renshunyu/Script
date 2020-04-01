#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir
deployhome=/home/aiuap30/flume/apache-flume-1.9.0-bin-ftp/lib
#sudo su - aiuap30 -c "cp $buildhome/dap/$1/target/*.jar $deployhome"
#sudo su - aiuap30 -c "cp $buildhome/dap/$1/libs/*.jar $deployhome"
cd $buildhome/dap/$1/target/
echo 'open 10.21.171.47
user aiiap aiiap
cd /data/aiiap/pulsar-flume/flume/apache-flume-1.9.0-bin-ftp/lib/
bin
prompt
mput *.jar
' |ftp -n
