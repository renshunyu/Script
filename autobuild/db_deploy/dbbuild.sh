#!/bin/sh

version=$1
svnhome=/home/aiuap/svnproject/program30/program/db�ű�/${version}
buildhome=/home/aiuap/svnproject/program30/builddir/db�ű�/${version}
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
rm -rf $buildhome
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cp -rf $svnhome $buildhome
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi

