#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/reportc
cp $buildhome/reportc/target/dist/reportc.war ~/package/sssia/��װ��/reportc/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
