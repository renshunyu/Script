#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.5.0_17
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/hom/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.5.0_17/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/tomcat_gather_syslog
buildhome=/home/aiuap/svnproject/program/builddir/ap_gather_syslog
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_gather_syslog/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/tomcat_gather_syslog/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止syslog平台完毕"
  break;
fi
echo "正在停止syslog平台，请稍后........"
sleep 1
done
rm -rf $deployhome/webapps/ap_gather_syslog2
result=$?
if [ $result != '0' ]
then
  echo "删除syslog平台部署目录错误"
  exit 1
fi
mkdir $deployhome/webapps/ap_gather_syslog2
if [ $result != '0' ]
then
  echo "创建syslog平台部署目录错误"
  exit 1
fi
cp $buildhome/target/dist/ap_gather_syslog2.war $deployhome/webapps/ap_gather_syslog2/ap_gather_syslog2.war
result=$?
if [ $result != '0' ]
then
  echo "拷贝syslog平台jar包错误"
  exit 1
fi
cd $deployhome/webapps/ap_gather_syslog2/
jar -xvf $deployhome/webapps/ap_gather_syslog2/ap_gather_syslog2.war
result=$?
if [ $result != '0' ]
then
  echo "解压syslog平台jar包错误"
  exit 1
fi
sh  $deployhome/syslogconfig/install.sh
sudo su - aiuap30 -c "sh $deployhome/bin/startup.sh"
echo $?
echo "syslog平台已经部署成功,请运行seeiap查看后台日志"
