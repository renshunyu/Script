#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

#deployhome=/home/aiuap30/data-upload-tools
deployhome=/home/aiuap30/azkaban
buildhome=/home/aiuap/svnproject/program30/builddir/azkaban
sudo su - aiuap30 -c "cd $deployhome/azkaban-0.1.0-SNAPSHOT/azkaban-web-server-0.1.0-SNAPSHOT/bin && sh azkaban-web-shutdown.sh"
sudo su - aiuap30 -c "cd $deployhome/azkaban-0.1.0-SNAPSHOT/azkaban-exec-server-0.1.0-SNAPSHOT/bin && sh azkaban-executor-shutdown.sh"
while  [ 1 ]
do
result=`ps -ef|grep azkaban|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome |wc -l`
if [ $result = '0' ]
then
  echo "azkabanֹͣ���"
  break;
fi
echo "azkaban����ֹͣ�����Ժ�........"
sleep 1
done



sudo su - aiuap30 -c "rm -rf $deployhome/azkaban*"
result=$?
if [ $result != '0' ]
then
  echo "ɾ��azkaban��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "cp $buildhome/build/distributions/*.tar.gz $deployhome/ -r"
result=$?
if [ $result != '0' ]
then
  echo "����azkaban��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/ && tar -zxvf azkaban-0.1.0-SNAPSHOT.tar.gz  && rm azkaban-0.1.0-SNAPSHOT.tar.gz "
sudo su - aiuap30 -c "cd $deployhome/azkaban-0.1.0-SNAPSHOT && tar -zxvf azkaban-exec-server-0.1.0-SNAPSHOT.tar.gz"
sudo su - aiuap30 -c "cd $deployhome/azkaban-0.1.0-SNAPSHOT && tar -zxvf azkaban-web-server-0.1.0-SNAPSHOT.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "��ѹazkaban��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "sh $deployhome/initconfig/install.sh"
result=$?
if [ $result != '0' ]
then
  echo "���������ļ�����"
  exit 1    
fi
sudo su - aiuap30 -c "cd $deployhome/azkaban-0.1.0-SNAPSHOT/azkaban-exec-server-0.1.0-SNAPSHOT/bin && nohup sh azkaban-executor-start.sh &" 
sleep 5 
sudo su - aiuap30 -c "cd $deployhome/azkaban-0.1.0-SNAPSHOT/azkaban-web-server-0.1.0-SNAPSHOT/bin && nohup sh azkaban-web-start.sh &"
sleep 5
echo "dac��Ŀ�Ѿ�����ɹ�"
exit 0
