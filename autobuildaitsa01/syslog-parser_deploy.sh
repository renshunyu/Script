#!/bin/sh
buildhome=/home/aiuap/svnproject/aitsa01/program/builddir

#/home/aiuap/svnproject/aitsa01/program/builddir/parser/log-parse-function/
cd $buildhome/$1/target
#echo 'open 10.1.198.58
echo 'open 10.21.171.58
user pulsar 1qaz!QAZ
cd /opt/pulsar/pulsar-2.4.0/hndx
bin
put *dependencies.jar
' |ftp -n

#expect -c "
#spawn ssh pulsar@10.21.171.59 cd /opt/pulsar/pulsar-2.4.0/ && bin/pulsar-admin functions update --jar test/xml-parse-function-1.0-SNAPSHOT-jar-with-dependencies.jar --classname com.asiainfo.dap.XmlParseFunction --inputs persistent://test/test/boss-ftp-flume-boss --output persistent://test/test/boss-ftp-ori-boss-log --user-config '{\"errorTopic\":\"persistent://test/test/boss-ftp-ori-boss-errlog\",\"exceptionTopic\":\"persistent://test/test/boss-ftp-ori-boss-exception\",\"record-tag-name\":\"LOG4A\"}' --tenant test --namespace test --name xml-parse --processing-guarantees EFFECTIVELY_ONCE --cpu 4 --ram 1073741824 --disk 68719476736 --parallelism 6
#expect \"*assword:\" {set timeout 300;  send \"1qaz\!QAZ\r\";}
#expect eof"
