#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/DAC_Script
cp $buildhome/DAC_Script.tar.gz ~/package/sssia/��װ��/DAC_Script/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
