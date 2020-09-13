#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir
deployhome=/home/aiiap/standardize

cd $buildhome/dap/$1/target
#echo 'open 10.1.198.60
echo 'open 10.21.171.59
user pulsar 1qaz!QAZ
cd /home/pulsar/canalbinlog-pulsar
bin
prompt
mput *-release.tar.gz
' |ftp -n

expect -c "
spawn ssh -p 22022 pulsar@10.21.171.59 cd /home/pulsar/canalbinlog-pulsar/ && cd canalbinlog-sink-pulsar && sh stop.sh ||echo ''  && rm -rf canalbinlog-sink-pulsar &&  tar -zxvf canalbinlog-sink-pulsar-release.tar.gz && cp /home/pulsar/canalbinlog-pulsar/config.properties /home/pulsar/canalbinlog-pulsar/canalbinlog-sink-pulsar/config && cd /home/pulsar/canalbinlog-pulsar/canalbinlog-sink-pulsar/ && sh start.sh
expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
expect eof"


#expect -c "
#spawn ssh pulsar@10.21.171.58 cd /opt/standardize/ && sh /opt/standardize/
#expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
#expect eof"
