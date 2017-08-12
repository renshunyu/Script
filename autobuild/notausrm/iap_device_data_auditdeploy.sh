#!bin/sh
export LANG=zh_CN.gb18030
deployhome=/home/aiuap/aiuap30/aiiapc/tomcat_iap_device_data_audit_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/iap_device_date_audit
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep '/home/aiuap/aiuap30/aiiapc/tomcat_iap_device_data_audit_rm'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/aiuap30/aiiapc/tomcat_iap_device_data_audit_rm|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止审计平台完毕"
  break;
fi
echo "正在停止审计平台，请稍后........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap_device_data_audit
result=$?
if [ $result != '0' ]
then
  echo "删除审计平台部署目录错误"
  exit 1
fi
#sudo mkdir $deployhome/webapps/iap
mkdir $deployhome/webapps/iap_device_data_audit
if [ $result != '0' ]
then
  echo "创建审计平台部署目录错误"
  exit 1
fi

#sudo cp /home/aiuap/svnproject/program30/builddir/iap/target/dist/iap.war /home/aiuap30/tomcat_iap30/webapps/iap/iap.war
cp $buildhome/target/dist/iap_device_data_audit.war $deployhome/webapps/iap_device_data_audit/iap_device_data_audit.war
result=$?
if [ $result != '0' ]
then
  echo "拷贝审计平台jar包错误"
  exit 1
fi
cd $deployhome/webapps/iap_device_data_audit/
jar -xvf $deployhome/webapps/iap_device_data_audit/iap_device_data_audit.war
result=$?
if [ $result != '0' ]
then
  echo "解压审计平台jar包错误"
  exit 1
fi

sh $deployhome/iap_device_data_audit_confinit/install.sh
sh $deployhome/bin/startup.sh
echo "iap_device_data_audit平台已经部署成功"
