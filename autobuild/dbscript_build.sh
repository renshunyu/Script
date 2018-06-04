#!bin/sh


svnhome=/home/aiuap/svnproject/program30/program/db脚本
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "更新svn目录错误"
  exit 1
fi
echo "更新svn目录成功"
rm -rf  $buildhome/db脚本
if [ $result != '0' ]
then
  echo "删除编译目录错误"
  exit 1
fi
cp -rf $svnhome $buildhome/db脚本
result=$?
if [ $result != '0' ]
then
  echo "拷贝目录错误"
  exit 1
fi
echo "成功"
