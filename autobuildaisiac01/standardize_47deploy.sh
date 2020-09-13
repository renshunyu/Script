#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir
deployhome=/home/aiiap/standardize

cd $buildhome/dap/$1/target
date
#echo 'open 10.1.198.60
echo 'open 10.21.171.47
user aiiap aiiap
cd /data/aiiap/standardize
bin
prompt
mput *.tar.gz
exit
' |ftp -n

date

expect -c "
spawn ssh -p 22022 aiiap@10.21.171.47 source ~/.bash_profile  && cd /data/aiiap/standardize &&cd standardize-component_mysql && sh stop.sh || echo "ֹͣ�쳣" && cd .. && rm -rf standardize-component_mysql &&  tar -zxvf standardize-component_mysql-release.tar.gz  && rm -f standardize-component_mysql-release.tar.gz && cp /data/aiiap/standardize/initconfig/* /data/aiiap/standardize/standardize-component_mysql/config && cd /data/aiiap/standardize/standardize-component_mysql && sh start.sh
expect \"*assword:\" {set timeout 300;  send \"aiiap\r\";}
expect eof"

