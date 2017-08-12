#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.5.0_17
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/hom/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.5.0_17/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/tomcat_gather_syslog
buildhome=/home/aiuap/svnproject/program/builddir/ap_gather_syslog
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_gather_syslog/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/tomcat_gather_syslog/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣsyslogƽ̨���"
  break;
fi
echo "����ֹͣsyslogƽ̨�����Ժ�........"
sleep 1
done
rm -rf $deployhome/webapps/ap_gather_syslog2
result=$?
if [ $result != '0' ]
then
  echo "ɾ��syslogƽ̨����Ŀ¼����"
  exit 1
fi
mkdir $deployhome/webapps/ap_gather_syslog2
if [ $result != '0' ]
then
  echo "����syslogƽ̨����Ŀ¼����"
  exit 1
fi
cp $buildhome/target/dist/ap_gather_syslog2.war $deployhome/webapps/ap_gather_syslog2/ap_gather_syslog2.war
result=$?
if [ $result != '0' ]
then
  echo "����syslogƽ̨jar������"
  exit 1
fi
cd $deployhome/webapps/ap_gather_syslog2/
jar -xvf $deployhome/webapps/ap_gather_syslog2/ap_gather_syslog2.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹsyslogƽ̨jar������"
  exit 1
fi
sh  $deployhome/syslogconfig/install.sh
sudo su - aiuap30 -c "sh $deployhome/bin/startup.sh"
echo $?
echo "syslogƽ̨�Ѿ�����ɹ�,������seeiap�鿴��̨��־"
