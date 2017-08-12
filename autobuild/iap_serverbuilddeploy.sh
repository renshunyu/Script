#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.5.0_17
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.5.0_17/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/tomcat_iap_server
buildhome=/home/aiuap/svnproject/program/builddir/iap_server
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep tomcat_iap_server|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/tomcat_iap_server/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止iap_server审计后台完毕"
  break;
fi
echo "正在停止iap_server审计后台，请稍后........"
sleep 1
done
rm -rf $deployhome/webapps/iap_server
result=$?
if [ $result != '0' ]
then
  echo "删除iap_server审计后台部署目录错误"
  exit 1
fi
mkdir $deployhome/webapps/iap_server
if [ $result != '0' ]
then
  echo "创建iap_server审计后台部署目录错误"
  exit 1
fi
cp $buildhome/target/dist/iap_server.war $deployhome/webapps/iap_server/iap_server.war
result=$?
if [ $result != '0' ]
then
  echo "拷贝iap_server审计后台jar包错误"
  exit 1
fi
cd $deployhome/webapps/iap_server/
jar -xvf $deployhome/webapps/iap_server/iap_server.war
result=$?
if [ $result != '0' ]
then
  echo "解压iap_server审计后台jar包错误"
  exit 1
fi
sh $deployhome/iap_serverconfinit/install.sh
sudo su - aiuap30 -c "sh $deployhome/bin/startup.sh"
echo $?
echo "iap_server审计后台已经部署成功,请运行seeuap查看后台日志"
