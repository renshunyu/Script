#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir
deployhome=/home/aiiap/standardize

cd $buildhome/dap/$1/target
#echo 'open 10.1.198.60
echo 'open 10.21.171.47
user aiiap aiiap
cd /data/aiiap/standardize
bin
prompt
mput *.tar.gz
' |ftp -n

echo 'open 10.21.171.60
user pulsar 1qaz!QAZ
cd /home/pulsar/standardize
bin
prompt
mput *.tar.gz
' |ftp -n

#expect -c "
#spawn ssh pulsar@10.21.171.58 cd /opt/standardize/ && sh /opt/standardize/
#expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
#expect eof"
