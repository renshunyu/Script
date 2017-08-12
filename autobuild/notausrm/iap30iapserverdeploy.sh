#!bin/sh
export LANG=zh_CN.gb18030
deployhome=/home/aiuap/aiuap30/aiiapc/iap_server_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/iap_server
cd $deployhome/iap_server
sh stop.sh >/dev/null
rm -rf $deployhome/iap_server
result=$?
if [ $result != '0' ]
then
  echo "ɾ��iap_server����Ŀ¼����"
  exit 1
fi
cp $buildhome/iap_server-3.0.tar.gz $deployhome/iap_server-3.0.tar.gz
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/
gunzip iap_server-3.0.tar.gz
tar -xvf $deployhome/iap_server-3.0.tar
rm iap_server-3.0.tar
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
sh $deployhome/iap_serverconfig/install.sh
cd $deployhome/iap_server
csh start.sh
echo $?
echo "iap_server�Ѿ�����ɹ�"
