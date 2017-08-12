#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap30/iap_server
buildhome=/home/aiuap/svnproject/program30/builddir/iap_server
cd $deployhome/iap_server
sudo sh stop.sh  >/dev/null
#ps -ef | grep 'iap_server'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
#sudo kill -9 `ps -ef | grep 'iap_server'|grep -v grep |grep -v tail |awk '{print $2}'`
result=`ps -ef|grep /home/aiuap30/iap_server/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止iap_server完毕"
#  break;
fi
echo "正在停止审计iap_server，请稍后........"
sleep 3

sudo rm -rf /home/aiuap30/iap_server/iap_server
echo "删除/home/aiuap30/iap_server/iap_server目录sucessful"
result=$?
if [ $result != '0' ]
then
  echo "删除审计iap_server部署目录错误"
  exit 1
fi
#sudo mkdir $deployhome/webapps/iap
#if [ $result != '0' ]
#then
#  echo "创建审计平台部署目录错误"
#  exit 1
#fi
sudo rm -rf /home/aiuap30/iap_server/iap_server-3.0.tar.gz 
echo "删除上次构建iap_server-3.0.tar.gz包成功"
sudo su aiuap30 -c "cp -r /home/aiuap/svnproject/program30/builddir/iap_server/iap_server-3.0.tar.gz  /home/aiuap30/iap_server/"
echo "复制移动iap_server-3.0.tar.gz成功"
result=$?
if [ $result != '0' ]
then
  echo "拷贝审计iap_server-3.0.tar.gz包错误"
  exit 1
fi
cd $deployhome
sudo su aiuap30 -c "tar -zxvf iap_server-3.0.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压审计iap_server-3.0.tar.gz错误"
  exit 1
fi
sudo sh $deployhome/iap_serverconfig/install.sh
echo "替换配置ok"
cd /home/aiuap30/iap_server/iap_server
sudo su aiuap30 -c "csh start.sh"

echo $?
echo "审计平台iap_server已经部署成功,请到/iap_server/log下查看日志"
