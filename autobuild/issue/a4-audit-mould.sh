#!bin/sh
buildhome=/home/aiuap/gitprojeck/AISIA/builddir
mkdir -p ~/package/sssia/��װ��/a4-audit-mould
cp $buildhome/a4-audit-mould/build/libs/a4-audit-mould.jar /home/aiuap/hunan_audit/a4-audit-mould

result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
cd /home/aiuap/hunan_audit/a4-audit-mould/bin
sh kill.sh
sh start.sh

#exit 0
