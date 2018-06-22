#!/bin/sh
if [ -z "$1" ]; then
 echo "参数不足"
 exit 1
fi

docpath="/home/aiuap/svnproject/program30/builddir/发布相关的文档"

svn update $docpath


mkdir -p ~/patch/$1/doc
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
vernum=`echo $1|awk -F"_" '{print $1}'|sed 's/aisia//g'`
cp $docpath/$vernum/移动4A项目审计补丁发布日志*.docx  ~/patch/$1/doc/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
