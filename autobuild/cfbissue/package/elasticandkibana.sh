#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
if [[ -z "$1" ]]; then
  echo "参数不足"
  exit 1
fi

packagepath=/home/aiuap/svnproject/program30rm/fbissue
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/install

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d install ]; then
  rm -fr install
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd install
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

mkdir -p ~/package/sssia/安装包/elastic/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp ./elastic.tar.gz ~/package/sssia/安装包/elastic/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi

mkdir -p ~/package/sssia/安装包/kibana/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp ./kibana.tar.gz ~/package/sssia/安装包/kibana/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
