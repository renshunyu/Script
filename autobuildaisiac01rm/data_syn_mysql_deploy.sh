#!/bin/sh
buildhome=/home/aiuap/svnproject/aisiac01/programrm/builddirrm

#sudo su - aiuap30 -c "cp $buildhome/dap/$1/target/*.jar $deployhome"
#sudo su - aiuap30 -c "cp $buildhome/dap/$1/libs/*.jar $deployhome"
cd $buildhome/dap/$1/target/
echo 'open 10.21.171.47
user aiiap aiiap
cd /data/aiiap/
bin
prompt
mput *dap-release.tar.gz
' |ftp -n



