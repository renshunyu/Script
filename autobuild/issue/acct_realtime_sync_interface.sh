#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/acct_realtime_sync_interface
cp $buildhome/acct_realtime_sync_interface/target/*tar.gz ~/package/sssia/��װ��/acct_realtime_sync_interface/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
