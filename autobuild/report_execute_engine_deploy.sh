#!/bin/sh
if [ $# -gt 0 ]; then
        echo "参数个数为$#个"
else
        echo "没有参数"
	exit 1
fi



buildhome=/home/aiuap/svnproject/program30/builddir
deployhome=/home/aiuap30/report_execute_engine
cd $buildhome/report_execute_engine/target/
echo ftpstart
echo 'open 10.1.198.54
user clouderauser clouderauser
cd /home/clouderauser/report_execute_engine
bin
put report_execute_engine-1.0.tar.gz
' |ftp -n
sleep 3

sudo rm -fr $deployhome/report_execute_engine-1.0
sudo rm -fr $deployhome/report_execute_engine-1.0.tar.gz

sudo su - aiuap30 -c "cp $buildhome/report_execute_engine/target/report_execute_engine-1.0.tar.gz $deployhome/"
sudo su - aiuap30 -c "cd $deployhome/ && tar -zxvf report_execute_engine-1.0.tar.gz"
#sudo su - aiuap30 -c "cd $deployhome/ && tar -zxvf report_execute_engine-1.0.tar.gz && cd initconfig && sh install.sh"
sudo rm -fr $deployhome/report_execute_engine-1.0/report_config/*


if [ -f $buildhome/report_execute_engine/example/$1 ]; then
	sudo su - aiuap30 -c "cp $buildhome/report_execute_engine/example/$1 $deployhome/report_execute_engine-1.0/report_config"
	sudo su - aiuap30 -c "cd $deployhome/initconfig && sh install.sh"
else
	echo $buildhome/report_execute_engine/example/$1不存在！
	exit 1

fi
echo 部署成功呢！
exit 0
