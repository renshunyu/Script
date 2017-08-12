#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/aiuap30/tomcat_iap_report_flex_server_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/iap_report_flex_server
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_report_flex_server_rm/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/aiuap30/tomcat_iap_report_flex_server_rm/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣ���ƽ̨���"
  break;
fi
echo "����ֹͣ���ƽ̨�����Ժ�........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap_report_flex_server
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
mkdir $deployhome/webapps/iap_report_flex_server
if [ $result != '0' ]
then
  echo "�������ƽ̨����Ŀ¼����"
  exit 1
fi
cp /home/aiuap/svnproject/program30rm/builddir/iap_report_flex_server/target/dist/iap_report_flex_server.war /home/aiuap/aiuap30/tomcat_iap_report_flex_server_rm/webapps/iap_report_flex_server/iap_report_flex_server.war
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/webapps/iap_report_flex_server/
jar -xvf /home/aiuap/aiuap30/tomcat_iap_report_flex_server_rm/webapps/iap_report_flex_server/iap_report_flex_server.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
#sh /home/aiuap/aiuap30/tomcat_iap_report_flex_server_rm/iapconfinit/install.sh
cp -rf /home/aiuap/svnproject/program30rm/builddir/iap_report_flex/dist/bin/*  /home/aiuap/aiuap30/tomcat_iap_report_flex_server_rm/webapps/iap_report_flex_server/
sh /home/aiuap/aiuap30/tomcat_iap_report_flex_server_rm/iap_flex_reportconfinit/install.sh
sudo su - aiuap30 -c "sh /home/aiuap/aiuap30/tomcat_iap_report_flex_server_rm/bin/startup.sh"
echo $?
echo "���ƽ̨�Ѿ�����ɹ�,������seeiap�鿴��̨��־"
