#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.7.0_80
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH
export PATH

deployhome=/home/aiuap30/report_execute_engine
buildhome=/home/aiuap/svnproject/program30/builddir/report_execute_engine
sudo su - aiuap30 -c "cd $deployhome/report_execute_engine-1.0/bin && sh stop.sh"

result=$(sudo pwdx `ps -ef|grep ReportApp|grep -v grep|awk '{print $2}'` |grep "$deployhome/report_execute_engine-1.0/bin"|wc -l)
if [ $result=='0' ]
then
  echo "ֹͣreport_execute_engine���"
#  break;
fi
echo "����ֹͣ���report_execute_engine�����Ժ�........"
sleep 3

sudo rm -rf $deployhome/report_execute_engine-1.0
echo "ɾ��$deployhome/report_execute_engine-1.0Ŀ¼sucessful"
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����report_execute_engine����Ŀ¼����"
  exit 1
fi
sudo rm -rf $deployhome/report_execute_engine-1.0*.tar.gz
echo "ɾ���ϴι���report_execute_engine���ɹ�"
sudo su aiuap30 -c "cp $buildhome/target/report_execute_engine-1.0*.tar.gz  $deployhome/"
echo "�����ƶ�report_execute_engine-1.0*.tar.gz�ɹ�"
result=$?
if [ $result != '0' ]
then
  echo "�������report_execute_engine-1.0*.tar.gz������"
  exit 1
fi
cd $deployhome
sudo su aiuap30 -c "cd $deployhome && tar -zxvf report_execute_engine-1.0*.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���report_execute_engine-1.0*.tar.gz����"
  exit 1
fi
sudo sh $deployhome/initconfig/install.sh
echo "�滻����ok"
cd /home/aiuap30/iap_server/iap_server
sudo su aiuap30 -c "source '/home/aiuap30/.bash_profile' && cd $deployhome/report_execute_engine-1.0/bin && sh start.sh"

echo $?
echo "���ƽ̨report_execute_engine�Ѿ�����ɹ�,�뵽/report_execute_engine/log�²鿴��־"
