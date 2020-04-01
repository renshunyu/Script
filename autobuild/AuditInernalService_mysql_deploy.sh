#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap30/auditinernalservice
buildhome=/home/aiuap/svnproject/program30/builddir/AuditInernalService_mysql
sudo su - aiuap30 -c "cd $deployhome/auditinernalservice-0.0.1-SNAPSHOT/bin && sh kill.sh "

while  [ 1 ]
do
result=`ps -ef|grep auditinernalservice-0.0.1-SNAPSHOT|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/auditinernalservice-0.0.1-SNAPSHOT/bin |wc -l`
if [ $result = '0' ]
then
  echo "stop auditinernalservice-0.0.1-SNAPSHOT done"
  break;
fi
echo "stop auditinernalservice-0.0.1-SNAPSHOT doing"
sleep 1
done



sudo su - aiuap30 -c "rm -rf $deployhome/auditinernalservice-0.0.1-SNAPSHOT"
result=$?
if [ $result != '0' ]
then
  echo "ɾ��auditinernalservice-0.0.1-SNAPSHOT��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "cp $buildhome/AuditInernalService/target/auditinernalservice-0.0.1-SNAPSHOT-RELEASE.tar.gz $deployhome/"
result=$?
if [ $result != '0' ]
then
  echo "����auditinernalservice-0.0.1-SNAPSHOT��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/ && tar -zxvf auditinernalservice-0.0.1-SNAPSHOT-RELEASE.tar.gz && rm auditinernalservice-0.0.1-SNAPSHOT-RELEASE.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "��ѹauditinernalservice-0.0.1-SNAPSHOT��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "sh $deployhome/initconfig/install.sh"
result=$?
if [ $result != '0' ]
then
  echo "���������ļ�����"
  exit 1    
fi
#cd $deployhome/auditinernalservice-0.0.1-SNAPSHOT
sudo su - aiuap30 -c "cd $deployhome/auditinernalservice-0.0.1-SNAPSHOT && mkdir file "
sudo su - aiuap30 -c "cd $deployhome/auditinernalservice-0.0.1-SNAPSHOT/bin && sh start.sh"
echo "�����ɹ�"
exit 0
