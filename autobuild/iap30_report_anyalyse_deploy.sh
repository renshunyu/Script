#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap30/tomcat_iapreport
buildhome=/home/aiuap/svnproject/program30/builddir/iap_report_analysis_server
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iapreport/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap30/tomcat_iapreport/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣ���report���"
  break;
fi
echo "����ֹͣ���report�����Ժ�........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap_report_analysis_server
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����report����Ŀ¼����"
  exit 1
fi
mkdir $deployhome/webapps/iap_report_analysis_server
sudo chmod 777 -R $deployhome/webapps/iap_report_analysis_server
sudo chown -R aiuap30:aiuap $deployhome/webapps/iap_report_analysis_server
if [ $result != '0' ]
then
  echo "�������report����Ŀ¼����"
  exit 1
fi
sudo cp /home/aiuap/svnproject/program30/builddir/iap_report_analysis_server/target/dist/iap_report_analysis_server.war /home/aiuap30/tomcat_iapreport/webapps/iap_report_analysis_server/iap_report_analysis_server.war

result=$?
if [ $result != '0' ]
then
  echo "�������report jar������"
  exit 1
fi
sudo chmod 777 -R $deployhome/webapps/iap_report_analysis_server/iap_report_analysis_server.war
sudo chown -R aiuap30:aiuap $deployhome/webapps/iap_report_analysis_server/
cd $deployhome/webapps/iap_report_analysis_server/
sudo jar -xvf iap_report_analysis_server.war
sleep 10
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
sudo rm -f /home/aiuap30/tomcat_iapreport/webapps/iap_report_analysis_server/iap_report_analysis_server.war

sudo chmod 777 -R $deployhome/webapps/iap_report_analysis_server/
sudo chown -R aiuap30:aiuap $deployhome/webapps/iap_report_analysis_server/
echo 'here is for testing'

source /home/aiuap30/tomcat_iapreport/iap_server_reportconfinit/install.sh
sleep 2
sudo su - aiuap30 -c "sh /home/aiuap30/tomcat_iapreport/bin/startup.sh"
sudo chmod -R 777 /home/aiuap30/tomcat_iapreport/webapps/iap_report_analysis_server/download
echo $?
sleep 2
#sh /home/aiuap30/tomcat_iapreport/iap_server_reportconfinit/install.sh
echo "���report�Ѿ�����ɹ�,��鿴��̨��־"
