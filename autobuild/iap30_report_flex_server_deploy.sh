#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap30/tomcat_iapreport_flex
buildhome=/home/aiuap/svnproject/program30/builddir/iap_report_flex_server
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iapreport_flex'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap30/tomcat_iapreport_flex/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止审计report完毕"
  break;
fi
echo "正在停止审计report，请稍后........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap_report_flex_server
result=$?
if [ $result != '0' ]
then
  echo "删除审计report部署目录错误"
  exit 1
fi
sudo mkdir $deployhome/webapps/iap_report_flex_server
sudo chmod 777 -R $deployhome/webapps/iap_report_flex_server
sudo chown -R aiuap30:aiuap $deployhome/webapps/iap_report_flex_server
if [ $result != '0' ]
then
  echo "创建审计report部署目录错误"
  exit 1
fi
sudo cp /home/aiuap/svnproject/program30/builddir/iap_report_flex_server/target/dist/iap_report_flex_server.war /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/
result=$?
if [ $result != '0' ]
then
  echo "拷贝审计report jar包错误"
  exit 1
fi
cd $deployhome/webapps/iap_report_flex_server/
sudo chmod 777 /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/iap_report_flex_server.war
sudo chown -R aiuap30:aiuap /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/
sudo chmod -R 777 /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/
sudo jar -xvf /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/iap_report_flex_server.war
result=$?
if [ $result != '0' ]
then
  echo "解压审计平台jar包错误"
  exit 1
fi
sudo chown -R aiuap30:aiuap /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/
sudo chmod -R 777 /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/
sudo cp -rf /home/aiuap/svnproject/program30/builddir/iap_report_flex/dist/bin/* /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/
sh /home/aiuap30/tomcat_iapreport_flex/iap_flex_reportconfinit/install.sh
sudo chmod -R 777 /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/
sudo chown -R aiuap30:aiuap /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/
sudo rm -rf /home/aiuap30/tomcat_iapreport_flex/webapps/iap_report_flex_server/iap_report_flex_server.war
sudo sed -i "s/DprovLocalRootDir=.*/DprovLocalRootDir=$1/g" /home/aiuap30/tomcat_iapreport_flex/bin/catalina.sh
sudo su - aiuap30 -c "sh /home/aiuap30/tomcat_iapreport_flex/bin/startup.sh"
echo $?
echo "审计report已经部署成功,请查看后台日志"
