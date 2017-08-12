#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#deployhome=/home/aiuap/aiuap30/tomcat_iap_rm
deployhome=/home/aiuap/aiuap30/tomcat_iap_release
buildhome=/home/aiuap/svnproject/release/builddir/iap
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_release/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/aiuap30/tomcat_iap_release/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣ���ƽ̨���"
  break;
fi
echo "����ֹͣ���ƽ̨�����Ժ�........"
sleep 1
done
rm -rf $deployhome/webapps/iap
#sudo su - aiuap30 -c "rm -rf $deployhome/webapps/iap"
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
mkdir $deployhome/webapps/iap
if [ $result != '0' ]
then
  echo "�������ƽ̨����Ŀ¼����"
  exit 1
fi
cp /home/aiuap/svnproject/release/builddir/iap/target/dist/iap.war /home/aiuap/aiuap30/tomcat_iap_release/webapps/iap/iap.war
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/webapps/iap/
jar -xvf /home/aiuap/aiuap30/tomcat_iap_release/webapps/iap/iap.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
sh /home/aiuap/aiuap30/tomcat_iap_release/iapconfinit/install.sh
sh /home/aiuap/aiuap30/tomcat_iap_release/bin/startup.sh
#sudo su - aiuap30 -c "sh /home/aiuap/aiuap30/tomcat_iap_release/bin/startup.sh"
echo $?
echo "���ƽ̨�Ѿ�����ɹ�,������seeiap�鿴��̨��־"
