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
  echo "ֹͣ���ƽ̨���"
  break;
fi
echo "����ֹͣ���ƽ̨�����Ժ�........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap_device_data_audit
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
#sudo mkdir $deployhome/webapps/iap
mkdir $deployhome/webapps/iap_device_data_audit
if [ $result != '0' ]
then
  echo "�������ƽ̨����Ŀ¼����"
  exit 1
fi

#sudo cp /home/aiuap/svnproject/program30/builddir/iap/target/dist/iap.war /home/aiuap30/tomcat_iap30/webapps/iap/iap.war
cp $buildhome/target/dist/iap_device_data_audit.war $deployhome/webapps/iap_device_data_audit/iap_device_data_audit.war
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/webapps/iap_device_data_audit/
jar -xvf $deployhome/webapps/iap_device_data_audit/iap_device_data_audit.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi

sh $deployhome/iap_device_data_audit_confinit/install.sh
sh $deployhome/bin/startup.sh
echo "iap_device_data_auditƽ̨�Ѿ�����ɹ�"
