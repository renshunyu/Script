#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/report_execute_engine
cp $buildhome/report_execute_engine/target/*tar.gz ~/package/sssia/��װ��/report_execute_engine/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
