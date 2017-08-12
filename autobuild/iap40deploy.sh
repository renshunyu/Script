#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/tomcat_iap40
buildhome=/home/aiuap/svnproject/program30/builddir/iap4.0
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap40/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/tomcat_iap40/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止审计平台完毕"
  break;
fi
echo "正在停止审计平台，请稍后........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap
result=$?
if [ $result != '0' ]
then
  echo "删除审计平台部署目录错误"
  exit 1
fi
sudo mkdir $deployhome/webapps/iap
if [ $result != '0' ]
then
  echo "创建审计平台部署目录错误"
  exit 1
fi
sudo cp /home/aiuap/svnproject/program30/builddir/iap4.0/target/dist/iap.war /home/aiuap/tomcat_iap40/webapps/iap/iap.war
result=$?
if [ $result != '0' ]
then
  echo "拷贝审计平台jar包错误"
  exit 1
fi
cd $deployhome/webapps/iap/
sudo jar -xvf /home/aiuap/tomcat_iap40/webapps/iap/iap.war
result=$?
if [ $result != '0' ]
then
  echo "解压审计平台jar包错误"
  exit 1
fi
sudo sh /home/aiuap/tomcat_iap40/iapconfinit/install.sh
result=$?
if [ $result != '0' ]
then
  echo "执行install.sh脚本错误"
  exit 1
fi
sudo sh /home/aiuap/tomcat_iap40/bin/startup.sh
sudo chmod 777 /home/aiuap/tomcat_iap40/webapps/iap/download
echo $?
echo "审计平台已经部署成功,请运行seeiap40查看后台日志"
