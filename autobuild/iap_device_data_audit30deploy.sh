#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap30/tomcat_iap_device_data_audit
buildhome=/home/aiuap/svnproject/program30/builddir/iap_device_date_audit
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_device_data_audit/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap30/tomcat_iap_device_data_audit/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "iap_device_data_audit_rm停止平台完毕"
  break;
fi
echo "正在停止iap_device_data_audit_rm，请稍后........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap_device_data_audit
result=$?
if [ $result != '0' ]
then
  echo "删除iap_device_data_audit_rm部署目录错误"
  exit 1
fi
sudo mkdir $deployhome/webapps/iap_device_data_audit
if [ $result != '0' ]
then
  echo "创建iap_device_data_audit部署目录错误"
  exit 1
fi
sudo cp /home/aiuap/svnproject/program30/builddir/iap_device_date_audit/target/dist/iap_device_data_audit.war /home/aiuap30/tomcat_iap_device_data_audit/webapps/iap_device_data_audit/iap_device_data_audit.war
result=$?
if [ $result != '0' ]
then
  echo "拷贝iap_device_data_audit的jar包错误"
  exit 1
fi
cd $deployhome/webapps/iap_device_data_audit
sudo jar -xvf /home/aiuap30/tomcat_iap_device_data_audit/webapps/iap_device_data_audit/iap_device_data_audit.war
result=$?
if [ $result != '0' ]
then
  echo "解压iap_device_data_audit的jar包错误"
  exit 1
fi
sudo sh /home/aiuap30/tomcat_iap_device_data_audit/iap_device_data_audit_confinit/install.sh
sudo su - aiuap30 -c "sh /home/aiuap30/tomcat_iap_device_data_audit/bin/startup.sh"
echo $?
echo "审计iap_device_data_audit已经部署成功."
