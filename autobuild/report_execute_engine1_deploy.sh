#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.7.0_80
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH
export PATH

deployhome=/home/aiuap30/report_execute_engine
buildhome=/home/aiuap/svnproject/program30/builddir/report_execute_engine
sudo su - aiuap30 -c "cd $deployhome/report_execute_engine-1.0/bin && sh stop.sh"

result=$(sudo pwdx `ps -ef|grep ReportApp|grep -v grep|awk '{print $2}'` |grep "$deployhome/report_execute_engine-1.0/bin"|wc -l)
if [ $result=='0' ]
then
  echo "停止report_execute_engine完毕"
#  break;
fi
echo "正在停止审计report_execute_engine，请稍后........"
sleep 3

sudo rm -rf $deployhome/report_execute_engine-1.0
echo "删除$deployhome/report_execute_engine-1.0目录sucessful"
result=$?
if [ $result != '0' ]
then
  echo "删除审计report_execute_engine部署目录错误"
  exit 1
fi
sudo rm -rf $deployhome/report_execute_engine-1.0*.tar.gz
echo "删除上次构建report_execute_engine包成功"
sudo su aiuap30 -c "cp $buildhome/target/report_execute_engine-1.0*.tar.gz  $deployhome/"
echo "复制移动report_execute_engine-1.0*.tar.gz成功"
result=$?
if [ $result != '0' ]
then
  echo "拷贝审计report_execute_engine-1.0*.tar.gz包错误"
  exit 1
fi
cd $deployhome
sudo su aiuap30 -c "cd $deployhome && tar -zxvf report_execute_engine-1.0*.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压审计report_execute_engine-1.0*.tar.gz错误"
  exit 1
fi
sudo sh $deployhome/initconfig/install.sh
echo "替换配置ok"
cd /home/aiuap30/iap_server/iap_server
sudo su aiuap30 -c "source '/home/aiuap30/.bash_profile' && cd $deployhome/report_execute_engine-1.0/bin && sh start.sh"

echo $?
echo "审计平台report_execute_engine已经部署成功,请到/report_execute_engine/log下查看日志"
