#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/program/builddir
deployhome=/home/aiiap/standardize

cd $buildhome/dap/$1/target
#echo 'open 10.1.198.60
echo 'open 10.21.171.59
user pulsar 1qaz!QAZ
cd /home/pulsar/binlogtomysql
bin
prompt
mput *-release.tar.gz
' |ftp -n

expect -c "
spawn ssh -p 22022 pulsar@10.21.171.59 cd /home/pulsar/binlogtomysql/ && rm -rf binlogtomysql &&  tar -zxvf binlogtomysql-release.tar.gz && cp /home/pulsar/binlogtomysql/config.properties /home/pulsar/binlogtomysql/binlogtomysql/config && cd /home/pulsar/binlogtomysql/binlogtomysql/ && sh start.sh
expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
expect eof"


#expect -c "spawn ssh -p 22022  pulsar@10.21.171.59 cd /home/pulsar/binlogtomysql && tar -zxvf binlogtomysql-release.tar.gz
#expect {
#"yes/no"
#{send "yes\r";}  
#"password:"
#{send "1qaz!QAZ\r";}
#"Password:"
#{send "1qaz!QAZ\r";}
#}
#expect eof"

