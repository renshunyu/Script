#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/aiuap30/iap_server
buildhome=/home/aiuap/svnproject/program/builddir/release/iap_server
#buildhome=/home/aiuap/svnproject/program/builddir/iap_server
#cd $deployhome/iap_server
#sh stop.sh >/dev/null
ps -ef|grep 'iap_server'|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep 'iap_server'|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣiap_server���"
  break;
fi
echo "����ֹͣiap_server�����Ժ�........"
sleep 1
done
rm -rf $deployhome/iap_server/*
result=$?
if [ $result != '0' ]
then
  echo "ɾ��iap_serverĿ¼����"
  exit 1
fi
#cp $buildhome/iap_server-3.0.tar.gz /home/aiuap/aiuap30/iap_server/iap_server-3.0.tar.gz
cp /home/aiuap/svnproject/program/builddir/iap_server/iap_server-3.0.tar.gz /home/aiuap/aiuap30/iap_server/
result=$?
if [ $result != '0' ]
then
  echo "����iap_server������"
  exit 1
fi
cd $deployhome/
gunzip iap_server-3.0.tar.gz
tar -xvf /home/aiuap/aiuap30/iap_server/iap_server-3.0.tar
 rm -rf iap_server-3.0.tar
result=$?
if [ $result != '0' ]
then
  echo "��ѹiap_server������"
  exit 1
fi
 sh $deployhome/iap_serverconfig/install.sh
sudo chmod -R 777 /home/aiuap/aiuap30/iap_server/
cd /home/aiuap/aiuap30/iap_server/iap_server/
csh /home/aiuap/aiuap30/iap_server/iap_server/start.sh
#sudo su - aiuap30 -c "csh /home/aiuap/aiuap30/iap_server/start.sh"
#echo $?
echo "iap_server�Ѿ�����ɹ�,��̨LOG��־��Ϣ����"
