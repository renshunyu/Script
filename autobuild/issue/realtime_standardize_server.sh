#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/realtime_standardize_server
cp $buildhome/realtime_standardize_server/target/*tar.gz ~/package/sssia/��װ��/realtime_standardize_server/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
