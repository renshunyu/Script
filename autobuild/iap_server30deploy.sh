#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap30/iap_server
buildhome=/home/aiuap/svnproject/program30/builddir/iap_server
cd $deployhome/iap_server
sudo sh stop.sh  >/dev/null
#ps -ef | grep 'iap_server'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9 
#sudo kill -9 `ps -ef | grep 'iap_server'|grep -v grep |grep -v tail |awk '{print $2}'`
result=`ps -ef|grep /home/aiuap30/iap_server/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣiap_server���"
#  break;
fi
echo "����ֹͣ���iap_server�����Ժ�........"
sleep 3

sudo rm -rf /home/aiuap30/iap_server/iap_server
echo "ɾ��/home/aiuap30/iap_server/iap_serverĿ¼sucessful"
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����iap_server����Ŀ¼����"
  exit 1
fi
#sudo mkdir $deployhome/webapps/iap
#if [ $result != '0' ]
#then
#  echo "�������ƽ̨����Ŀ¼����"
#  exit 1
#fi
sudo rm -rf /home/aiuap30/iap_server/iap_server-3.0.tar.gz 
echo "ɾ���ϴι���iap_server-3.0.tar.gz���ɹ�"
sudo su aiuap30 -c "cp -r /home/aiuap/svnproject/program30/builddir/iap_server/iap_server-3.0.tar.gz  /home/aiuap30/iap_server/"
echo "�����ƶ�iap_server-3.0.tar.gz�ɹ�"
result=$?
if [ $result != '0' ]
then
  echo "�������iap_server-3.0.tar.gz������"
  exit 1
fi
cd $deployhome
sudo su aiuap30 -c "tar -zxvf iap_server-3.0.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���iap_server-3.0.tar.gz����"
  exit 1
fi
sudo sh $deployhome/iap_serverconfig/install.sh
echo "�滻����ok"
cd /home/aiuap30/iap_server/iap_server
sudo su aiuap30 -c "csh start.sh"

echo $?
echo "���ƽ̨iap_server�Ѿ�����ɹ�,�뵽/iap_server/log�²鿴��־"
