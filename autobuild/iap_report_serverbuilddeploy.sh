#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.5.0_17
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.5.0_17/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/tomcat_iapreport
buildhome=/home/aiuap/svnproject/program/builddir/iap_report_server
cd $deployhome/bin
sh shutdown.sh >/dev/null 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/tomcat_iapreport/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止iap报表后台完毕"
  break;
fi
echo "正在停止iap报表后台，请稍后........"
sleep 1
done
rm -rf $deployhome/webapps/iap_server_report
result=$?
if [ $result != '0' ]
then
  echo "删除iap报表后台部署目录错误"
  exit 1
fi
mkdir $deployhome/webapps/iap_server_report
if [ $result != '0' ]
then
  echo "创建iap报表后台部署目录错误"
  exit 1
fi
cp $buildhome/target/dist/iap_server_report.war $deployhome/webapps/iap_server_report/iap_server_report.war
result=$?
if [ $result != '0' ]
then
  echo "拷贝iap报表后台jar包错误"
  exit 1
fi
cd $deployhome/webapps/iap_server_report/
jar -xvf $deployhome/webapps/iap_server_report/iap_server_report.war
result=$?
if [ $result != '0' ]
then
  echo "解压iap报表后台jar包错误"
  exit 1
fi
sh  $deployhome/iap_server_reportconfinit/install.sh
sudo su - aiuap30 -c "sh $deployhome/bin/startup.sh"
echo $?
echo "iap报表后台已经部署成功,请运行seeuap查看后台日志"
