#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/ap_standardize_server
cp $buildhome/ap_standardize_server/dist/*.tar.gz ~/package/sssia/��װ��/ap_standardize_server/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
