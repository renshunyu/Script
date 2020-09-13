#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir
deployhome=/home/aiiap/standardize

cd $buildhome/dap/$1/target
#echo 'open 10.1.198.60
echo 'open 10.21.171.59
user pulsar 1qaz!QAZ
cd /opt/pulsar/pulsar-2.4.0/connectors
bin
prompt
mput *.nar
' |ftp -n

#expect -c "
#spawn ssh pulsar@10.21.171.58 cd /opt/standardize/ && sh /opt/standardize/
#expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
#expect eof"
