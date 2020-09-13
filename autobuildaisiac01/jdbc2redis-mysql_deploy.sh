#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir
#deployhome=/home/aiiap/standardize

cd $buildhome/dap/$1/target
echo 'open 10.21.171.59
user pulsar 1qaz!QAZ
cd /home/pulsar/jdbc2redis-mysql
bin
prompt
mput *.tar.gz
' |ftp -n

expect -c "
spawn ssh -p 22022 pulsar@10.21.171.59 cd /home/pulsar/jdbc2redis-mysql/ &&cd jdbc2redis-mysql && sh stop.sh ||echo '' &&cd .. && rm -rf jdbc2redis-mysql &&  tar -zxvf jdbc2redis-mysql-release.tar.gz  && cp /home/pulsar/jdbc2redis-mysql/conf.properties /home/pulsar/jdbc2redis-mysql/jdbc2redis-mysql/config && cd /home/pulsar/jdbc2redis-mysql/jdbc2redis-mysql/ && sh start.sh
expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
expect eof"


#expect -c "
#spawn ssh pulsar@10.21.171.58 cd /opt/standardize/ && sh /opt/standardize/
#expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
#expect eof"
