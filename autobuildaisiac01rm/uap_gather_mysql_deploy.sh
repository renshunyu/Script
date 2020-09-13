#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/programrm/builddirrm

#sudo su - aiuap30 -c "cp $buildhome/dap/$1/target/*.jar $deployhome"
#sudo su - aiuap30 -c "cp $buildhome/dap/$1/libs/*.jar $deployhome"
cd $buildhome/dap/$1/target/dist/
echo 'open 10.21.171.47
user aiiap aiiap
cd /data/aiiap/data_syn_mysql_package/lib/
bin
prompt
mput *.jar
' |ftp -n




