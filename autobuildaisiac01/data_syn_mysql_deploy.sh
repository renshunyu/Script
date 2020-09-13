#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir

cd $buildhome/dap/$1/target/
echo 'open 10.21.171.47
user aiiap aiiap
cd /data/aiiap/data_syn_mysql/
bin
prompt
mput *.tar.gz
' |ftp -n

echo 'open 10.21.171.60
user pulsar 1qaz!QAZ
cd /home/pulsar/data_syn_mysql/
bin
prompt
mput *.tar.gz
' |ftp -n

expect -c "
spawn ssh -p 22022 pulsar@10.21.171.60 cd /home/pulsar/data_syn_mysql/ &&cd data_syn_mysql_dap && sh stop.sh ||echo '' &&cd .. && rm -rf data_syn_mysql_dap &&  tar -zxvf data_syn_mysql_dap-release.tar.gz  && rm -f data_syn_mysql_dap-release.tar.gz &&cp -r /home/pulsar/data_syn_mysql/data_syn_mysql_dap/conf /home/pulsar/data_syn_mysql/data_syn_mysql_dap/confbak&&cp /home/pulsar/data_syn_mysql/initconfig/* /home/pulsar/data_syn_mysql/data_syn_mysql_dap/conf && cd /home/pulsar/data_syn_mysql/data_syn_mysql_dap/ && sh start.sh
expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
expect eof"


