#!bin/sh
export LANG=zh_CN.gb18030
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export PATH

deployhome=/home/aiuap/aiuap30/aiiapc/gather30/ap_gather_server_tcp-xml_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir
cd $deployhome/ap_gather_server_tcp-xml_rm
pwd
#sudo su aiuap30 -c "csh stop.sh ap_gather_server_tcp-xml"
sudo kill -9 $(ps -ef|grep ap_gather_server_tcp-xml_rm|grep -v grep|awk '{print $2}')

while  [ 1 ]
do
result=`ps -ef|grep ap_gather_server_tcp-xml_rm|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣ�ɼ����"
  break;
fi
echo "����ֹͣ�ɼ������Ժ�........"
sleep 1
done



rm -rf $deployhome/ap_gather_server_tcp-xml_rm
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
cp $buildhome/ap_gather_server.tar.gz $deployhome/
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/
pwd
gunzip ap_gather_server.tar.gz
tar -xvf ap_gather_server.tar
mv ap_gather_server ap_gather_server_tcp-xml_rm
rm ap_gather_server.tar
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
sh $deployhome/initconfig/install.sh
cd $deployhome/ap_gather_server_tcp-xml_rm/
csh start.sh ap_gather_server_tcp-xml_rm
echo $?
echo "�ɼ��Ѿ�����ɹ�"
exit 0
