#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/aiuap30/tomcat_iap_report_analysis_server_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/iap_device_date_audit
cd $deployhome/bin
#sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_report_analysis_server_rm/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs  kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/aiuap30/tomcat_iap_report_analysis_server_rm/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "iap_report_analysis_server_rmֹͣƽ̨���"
  break;
fi
echo "����ֹͣiap_report_analysis_server_rm�����Ժ�........"
sleep 1
done
rm -rf $deployhome/webapps/iap_report_analysis_server
result=$?
if [ $result != '0' ]
then
  echo "ɾ��iap_report_analysis_server_rm����Ŀ¼����"
  exit 1
fi
mkdir $deployhome/webapps/iap_report_analysis_server
if [ $result != '0' ]
then
  echo "����iap_report_analysis_server_rm����Ŀ¼����"
  exit 1
fi
cp /home/aiuap/svnproject/program30rm/iap_report_analysis_server/target/dist/iap_report_analysis_server.war /home/aiuap/aiuap30/tomcat_iap_report_analysis_server_rm/webapps/iap_report_analysis_server/iap_report_analysis_server.war
result=$?
if [ $result != '0' ]
then
  echo "����iap_report_analysis_server_rm��jar������"
  exit 1
fi
cd $deployhome/webapps/iap_report_analysis_server
jar -xvf /home/aiuap/aiuap30/tomcat_iap_report_analysis_server_rm/webapps/iap_report_analysis_server/iap_report_analysis_server.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹiap_report_analysis_server��jar������"
  exit 1
fi
sh /home/aiuap/aiuap30/tomcat_iap_report_analysis_server_rm/iap_server_reportconfinit/install.sh
#sudo su - aiuap30 -c "sh /home/aiuap/aiuap30/tomcat_iap_report_analysis_server_rm/bin/startup.sh"
sh /home/aiuap/aiuap30/tomcat_iap_report_analysis_server_rm/bin/startup.sh
echo $?
echo "���iap_report_analysis_server�Ѿ�����ɹ�."
