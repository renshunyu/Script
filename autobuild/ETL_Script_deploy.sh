#!bin/sh

deployhome=/home/aiuap30/data-integration/workspace
buildhome=/home/aiuap/svnproject/program30/builddir/ETL_Script

sudo su - aiuap30 -c "cp $buildhome/集团规范/取数管理/系统日志取数_河南/* $deployhome/systemloggetdata_henan/"

sudo su - aiuap30 -c "cp $buildhome/集团规范/取数管理/应用日志取数_河南/* $deployhome/apploggetdata_henan/"

sudo su - aiuap30 -c "cp $buildhome/集团规范/取数管理/主从账号取数_河南/GetMainSubAcct/* $deployhome/acctgetdata_henan/"

sudo su - aiuap30 -c "cp $buildhome/集团规范/取数管理/自定义SQL取数_河南/CustomizeSQL/* $deployhome/custemgetdata_henan/"

sudo su - aiuap30 -c "sh /home/aiuap30/data-integration/workspace/initconfig/installhenan.sh"

result=$?
if [ $result != '0' ]
then
  echo "拷贝data-reporting-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
echo "ETL_Script项目已经部署成功"
exit 0
