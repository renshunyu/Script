#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.7.0_80
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

#deployhome=/home/aiuap30/data-upload-tools
deployhome=/home/aiuap30/tomcat_reportcs
buildhome=/home/aiuap/svnproject/program30/builddir
sudo su - aiuap30 -c "cd $deployhome/bin && sh shutdown.sh"

while  [ 1 ]
do
result=`ps -ef|grep tomcat_reportcs|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/bin |wc -l`
if [ $result = '0' ]
then
  echo "data-monitorֹͣ���"
  break;
fi
echo "data-monitor����ֹͣ�����Ժ�........"
sleep 1
done



sudo su - aiuap30 -c "rm -rf $deployhome/webapps/reportc/*"
sudo su - aiuap30 -c "rm -rf $deployhome/webapps/reports/*"
result=$?
if [ $result != '0' ]
then
  echo "ɾ��report��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "cp $buildhome/reportc/target/dist/reportc.war $deployhome/webapps/reportc/"
sudo su - aiuap30 -c "cp $buildhome/reports/target/reports.war $deployhome/webapps/reports/"
result=$?
if [ $result != '0' ]
then
  echo "����report��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/webapps/reportc/ && jar -xvf reportc.war && rm reportc.war"
sudo su - aiuap30 -c "cd $deployhome/webapps/reports/ && jar -xvf reports.war && rm reports.war"
result=$?
if [ $result != '0' ]
then
  echo "��ѹreport��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "sh $deployhome/initconfig/install.sh"
result=$?
if [ $result != '0' ]
then
  echo "���������ļ�����"
  exit 1    
fi
sudo su - aiuap30 -c "cd $deployhome/bin && sh startup.sh"          
echo "report��Ŀ�Ѿ�����ɹ�"
exit 0
