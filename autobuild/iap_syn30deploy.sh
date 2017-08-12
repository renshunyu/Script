#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.5.0_17
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.5.0_17/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap30/tomcat_iap_syn
buildhome=/home/aiuap/svnproject/program30/builddir/iap_syn
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_syn'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap30/tomcat_iap_syn/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣ���ƽ̨���"
  break;
fi
echo "����ֹͣ���ƽ̨�����Ժ�........"
sleep 1
done
sudo rm -rf $deployhome/webapps/iap_syn
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
sudo mkdir $deployhome/webapps/iap_syn
if [ $result != '0' ]
then
  echo "�������ƽ̨����Ŀ¼����"
  exit 1
fi
sudo cp /home/aiuap/svnproject/program30/builddir/iap_syn/target/dist/iap_syn.war /home/aiuap30/tomcat_iap_syn/webapps/iap_syn/iap_syn.war
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/webapps/iap_syn/
sudo jar -xvf /home/aiuap30/tomcat_iap_syn/webapps/iap_syn/iap_syn.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
sudo sh /home/aiuap30/tomcat_iap_syn/iap_syn_confinit/install.sh
sudo su - aiuap30 -c "sh /home/aiuap30/tomcat_iap_syn/bin/startup.sh"
echo $?
echo "���ƽ̨�Ѿ�����ɹ�,������seeiap�鿴��̨��־"
