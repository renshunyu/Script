#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/data-upload-tools
cp $buildhome/data-upload-tools/target/*tar.gz ~/package/sssia/��װ��/data-upload-tools/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
