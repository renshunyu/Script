#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.5.0_17
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.5.0_17/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/tomcat_iapreport
buildhome=/home/aiuap/svnproject/program/builddir/iap_report_server
cd $deployhome/bin
sh shutdown.sh >/dev/null 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/tomcat_iapreport/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣiap�����̨���"
  break;
fi
echo "����ֹͣiap�����̨�����Ժ�........"
sleep 1
done
rm -rf $deployhome/webapps/iap_server_report
result=$?
if [ $result != '0' ]
then
  echo "ɾ��iap�����̨����Ŀ¼����"
  exit 1
fi
mkdir $deployhome/webapps/iap_server_report
if [ $result != '0' ]
then
  echo "����iap�����̨����Ŀ¼����"
  exit 1
fi
cp $buildhome/target/dist/iap_server_report.war $deployhome/webapps/iap_server_report/iap_server_report.war
result=$?
if [ $result != '0' ]
then
  echo "����iap�����̨jar������"
  exit 1
fi
cd $deployhome/webapps/iap_server_report/
jar -xvf $deployhome/webapps/iap_server_report/iap_server_report.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹiap�����̨jar������"
  exit 1
fi
sh  $deployhome/iap_server_reportconfinit/install.sh
sudo su - aiuap30 -c "sh $deployhome/bin/startup.sh"
echo $?
echo "iap�����̨�Ѿ�����ɹ�,������seeuap�鿴��̨��־"
