#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#deployhome=/home/aiuap/aiuap30/tomcat_iap_rm
deployhome=/home/aiuap/aiuap30/tomcat_iap_increment
buildhome=/home/aiuap/svnproject/release/builddir/iap
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_increment/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/aiuap30/tomcat_iap_increment/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止审计平台完毕"
  break;
fi
echo "正在停止审计平台，请稍后........"
sleep 1
done
#rm -rf $deployhome/webapps/iap
rm -rf $deployhome/webapps/iap
result=$?
if [ $result != '0' ]
then
  echo "删除审计平台部署目录错误"
  exit 1
fi
mkdir $deployhome/webapps/iap
if [ $result != '0' ]
then
  echo "创建审计平台部署目录错误"
  exit 1
fi
cp $buildhome/target/dist/iap.war $deployhome/webapps/iap/iap.war
result=$?
if [ $result != '0' ]
then
  echo "拷贝审计平台jar包错误"
  exit 1
fi
cd $deployhome/webapps/iap/
jar -xvf $deployhome/webapps/iap/iap.war
result=$?
if [ $result != '0' ]
then
  echo "解压审计平台jar包错误"
  exit 1
fi
sh $deployhome/iapconfinit/install.sh
sh $deployhome/bin/startup.sh
echo $?
echo "审计平台已经部署成功,请运行seeiap查看后台日志"
