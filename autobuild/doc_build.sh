#!bin/sh


svnhome=/home/aiuap/svnproject/program30/program/������ص��ĵ�
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
echo "����svnĿ¼�ɹ�"
rm -rf  $buildhome/������ص��ĵ�
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cp -rf $svnhome $buildhome/������ص��ĵ�
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
echo "�ɹ�"
