#!bin/sh


svnhome=/home/aiuap/svnproject/program30/program/db�ű�
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
echo "����svnĿ¼�ɹ�"
rm -rf  $buildhome/db�ű�
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cp -rf $svnhome $buildhome/db�ű�
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
echo "�ɹ�"
