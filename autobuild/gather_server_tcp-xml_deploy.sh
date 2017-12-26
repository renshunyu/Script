#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap30/gather30/ap_gather_server_tcp-xml
buildhome=/home/aiuap/svnproject/program30/builddir/ap_gather_Server
#cd $deployhome/ap_gather_server_tcp-xml
#sudo su aiuap30 -c "pwd"
#sudo su aiuap30 -c "csh stop.sh ap_gather_server_tcp-xml"
sudo kill -9 $(sudo pwdx `ps -ef|grep ap_gather_server_tcp-xml|grep -v grep|awk '{print $2}'`|grep $deployhome/ap_gather_server_tcp-xml|awk '{print $1}')

while  [ 1 ]
do
result=$(sudo pwdx `ps -ef|grep ap_gather_server_tcp-xml|grep -v grep|awk '{print $2}'`|grep $deployhome/ap_gather_server_tcp-xml|wc -l)
if [ $result = '0' ]
then
  echo "ֹͣ�ɼ����"
  break;
fi
echo "����ֹͣ�ɼ������Ժ�........"
sleep 1
done



sudo su aiuap30 -c "rm -rf $deployhome/ap_gather_server_tcp-xml"
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
sudo su aiuap30 -c "cp /home/aiuap/svnproject/program30/builddir/ap_gather_server.tar.gz /home/aiuap30/gather30/ap_gather_server_tcp-xml"
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/
sudo su aiuap30 -c "pwd"
sudo su aiuap30 -c "gunzip ap_gather_server.tar.gz"
sudo su aiuap30 -c "tar -xvf ap_gather_server.tar"
sudo su aiuap30 -c "mv ap_gather_server ap_gather_server_tcp-xml"
sudo su aiuap30 -c "rm ap_gather_server.tar"
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
sudo su aiuap30 -c "sh $deployhome/initconfig/install.sh"
cd $deployhome/ap_gather_server_tcp-xml/
sudo su - aiuap30 -c "cd $deployhome/ap_gather_server_tcp-xml/;csh start.sh ap_gather_server_tcp-xml"
echo $?
echo "�ɼ��Ѿ�����ɹ�"
exit 0
