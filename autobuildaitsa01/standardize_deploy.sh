#!/bin/sh
buildhome=/home/aiuap/svnproject/aitsa01/program/builddir
deployhome=/home/aiiap/standardize_hndx

cd $buildhome/standardize/target
#echo 'open 10.1.198.60
echo 'open 10.21.171.47
user aiiap aiiap
cd /data/aiiap/standardize_hndx
bin
prompt
mput *.tar.gz
' |ftp -n

echo 'open 10.21.171.60
user pulsar 1qaz!QAZ
cd /home/pulsar/standardize_hndx
bin
prompt
mput *.tar.gz
' |ftp -n

expect -c "
spawn ssh -p 22022 aiiap@10.21.171.47 source .bash_profile && cd /data/aiiap/standardize_hndx/auditStdServer && sh stop.sh || echo "ֹͣʧ�ܣ�" && cd .. && rm -fr auditStdServer && tar -zxvf auditStdServer-release.tar.gz && rm auditStdServer-release.tar.gz &&sh /data/aiiap/standardize_hndx/initconfig/install.sh && cd auditStdServer && sh start.sh
expect \"*assword:\" {set timeout 300;  send \"aiiap\r\";}
expect eof"
