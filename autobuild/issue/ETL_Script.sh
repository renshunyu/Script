#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/ETL_Script
cp $buildhome/ETL_Script.tar.gz ~/package/sssia/��װ��/ETL_Script/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
