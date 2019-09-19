#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.7.0_80
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap/aiuap30/aiiapc/tomcat_reportcs_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir
sudo su - aiuap30 -c "cd $deployhome/bin && sh shutdown.sh"

while  [ 1 ]
do
result=`ps -ef|grep tomcat_reportcs_rm|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/bin |wc -l`
if [ $result = '0' ]
then
  echo "reportcsֹͣ���"
  break;
fi
echo "reportcs����ֹͣ�����Ժ�........"
sleep 1
done



rm -rf $deployhome/webapps/reportc/*
rm -rf $deployhome/webapps/reports/*
result=$?
if [ $result != '0' ]
then
  echo "ɾ��report��Ŀ����"
  exit 1
fi
cp $buildhome/reportc/target/dist/reportc.war $deployhome/webapps/reportc/
cp $buildhome/reports/target/reports.war $deployhome/webapps/reports/
result=$?
if [ $result != '0' ]
then
  echo "����report��Ŀ����"
  exit 1
fi
cd $deployhome/webapps/reportc/ && jar -xvf reportc.war && rm reportc.war
cd $deployhome/webapps/reports/ && jar -xvf reports.war && rm reports.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹreport��Ŀ����"
  exit 1
fi
sh $deployhome/initconfig/install.sh
result=$?
if [ $result != '0' ]
then
  echo "���������ļ�����"
  exit 1    
fi
cd $deployhome/bin && sh startup.sh    
echo "report��Ŀ�Ѿ�����ɹ�"
exit 0
