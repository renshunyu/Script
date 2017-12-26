#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap30/data-upload-tools
buildhome=/home/aiuap/svnproject/program30/builddir/data-upload-tools
sudo su - aiuap30 -c "cd $deployhome/data-upload-tools-0.0.1-SNAPSHOT/bin && sh stop.sh all"

while  [ 1 ]
do
result=`ps -ef|grep dispatch-center|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/data-upload-tools-0.0.1-SNAPSHOT/bin |wc -l`
if [ $result = '0' ]
then
  echo "dispatch-centerֹͣ���"
  break;
fi
echo "dispatch-center����ֹͣ�����Ժ�........"
sleep 1
done

while  [ 1 ]
do
result=`ps -ef|grep data-preprocessing|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/data-upload-tools-0.0.1-SNAPSHOT/bin |wc -l`
if [ $result = '0' ]
then
  echo "data-preprocessingֹͣ���"
  break;
fi
echo "data-preprocessing����ֹͣ�����Ժ�........"
sleep 1
done

while  [ 1 ]
do
result=`ps -ef|grep result-analysis|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/data-upload-tools-0.0.1-SNAPSHOT/bin |wc -l`
if [ $result = '0' ]
then
  echo "result-analysisֹͣ���"
  break;
fi
echo "result-analysis����ֹͣ�����Ժ�........"
sleep 1
done



sudo su - aiuap30 -c "rm -rf $deployhome/data-upload-tools-0.0.1-SNAPSHOT"
result=$?
if [ $result != '0' ]
then
  echo "ɾ��data-upload-tools-0.0.1-SNAPSHOT��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "cp $buildhome/target/data-upload-tools-0.0.1-SNAPSHOT-release.tar.gz $deployhome/"
result=$?
if [ $result != '0' ]
then
  echo "����data-upload-tools-0.0.1-SNAPSHOT��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/ && tar -zxvf data-upload-tools-0.0.1-SNAPSHOT-release.tar.gz && rm data-upload-tools-0.0.1-SNAPSHOT-release.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "��ѹdata-upload-tools-0.0.1-SNAPSHOT��Ŀ����"
  exit 1
fi
sudo su - aiuap30 -c "sh $deployhome/initconfig/install.sh"
result=$?
if [ $result != '0' ]
then
  echo "���������ļ�����"
  exit 1    
fi          
#cd $deployhome/data-upload-tools-0.0.1-SNAPSHOT/bin/
#sudo su - aiuap30 -c "sh start.sh"
#echo $?
#echo "data-upload-tools-0.0.1-SNAPSHOT��Ŀ�Ѿ�����ɹ�"
exit 0
