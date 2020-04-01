#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir
deployhome=/opt/pulsar/pulsar-2.4.0/test

cd $buildhome/dap/$1/target
#echo 'open 10.1.198.60
echo 'open 10.21.171.59
user pulsar 1qaz!QAZ
cd /opt/pulsar/pulsar-2.4.0/connectors
bin
put *.nar
' |ftp -n

#expect -c "
#spawn ssh pulsar@10.21.171.58 cd /opt/pulsar/pulsar-2.4.0/ && bin/pulsar-admin sinks update --classname com.asiainfo.dap.JdbcAutoSchemaSink --archive test/pulsar-mysql-sink-2.4.0.nar --inputs persistent://test/test/boss-ftp-ori-boss-log --tenant test --namespace test --name test-mysql-sink --sink-config-file test/conf/pulsar-mysql-sink/pulsar-mysql-sink-two.yaml --cpu 1 --ram 2147483648 --disk 25769803776 --parallelism 1
#expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
#expect eof"
