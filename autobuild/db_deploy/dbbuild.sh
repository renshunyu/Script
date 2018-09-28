#!/bin/sh

version=$1
svnhome=/home/aiuap/svnproject/program30/program/db½Å±¾/${version}
buildhome=/home/aiuap/svnproject/program30/builddir/db½Å±¾/${version}
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "¸üĞÂsvnÄ¿Â¼´íÎó"
  exit 1
fi
rm -rf $buildhome
if [ $result != '0' ]
then
  echo "É¾³ı±àÒëÄ¿Â¼´íÎó"
  exit 1
fi
cp -rf $svnhome $buildhome
if [ $result != '0' ]
then
  echo "¿½±´Ä¿Â¼´íÎó"
  exit 1
fi

