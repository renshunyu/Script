#!bin/sh


svnhome=/home/aiuap/svnproject/program30/program/install
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
echo "����svnĿ¼�ɹ�"
rm -rf  $buildhome/install
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cp -rf $svnhome $buildhome/install
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
echo "�ɹ�"
