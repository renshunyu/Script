#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

mkdir -p ~/package/sssia/��װ��/azkaban
cp $buildhome/azkaban/build/distributions/azkaban*.tar.gz ~/package/sssia/��װ��/azkaban/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
