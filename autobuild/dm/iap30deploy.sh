#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=$(echo $CLASSPATH|sed 's/jdk1.6.0_31/jdk1.8.0_121/g')
export PATH=$(echo $PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin|sed 's/jdk1.6.0_31/jdk1.8.0_121/g')



deployhome=/home/aiuap30/tomcat_iap_dm
buildhome=/home/aiuap/dameng/builddir/iap
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_dm/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap30/tomcat_iap_dm/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣ���ƽ̨���"
  break;
fi
echo "����ֹͣ���ƽ̨�����Ժ�........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
sudo su aiuap30 -c "mkdir $deployhome/webapps/iap"
if [ $result != '0' ]
then
  echo "�������ƽ̨����Ŀ¼����"
  exit 1
fi

sudo su aiuap30 -c "cp /home/aiuap/dameng/builddir/iap/target/dist/iap.war /home/aiuap30/tomcat_iap_dm/webapps/iap/iap.war"
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/webapps/iap/
sudo su aiuap30 -c "jar -xvf /home/aiuap30/tomcat_iap_dm/webapps/iap/iap.war"
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi

sudo su aiuap30 -c "sh /home/aiuap30/tomcat_iap_dm/iapconfinit/install.sh"
sudo su aiuap30 -c "sh /home/aiuap30/tomcat_iap_dm/bin/startup.sh"
sudo chmod 777 /home/aiuap30/tomcat_iap_dm/webapps/iap/download
echo $?
echo "���ƽ̨�Ѿ�����ɹ�,������seeiap30�鿴��̨��־"
