#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.7.0_80
export M2_HOME=/usr/java/apache-maven-3.3.9
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
if [[ -z "$1" ]]; then
  echo "参数不足"
  exit 1
fi

packagepath=/home/aiuap/svnproject/program30rm/fbissue
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/report_execute_engine

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d report_execute_engine ]; then
  rm -fr report_execute_engine
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd report_execute_engine
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi


mvn clean package -Dmaven.test.skip=true >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"

mkdir -p ~/package/sssia/安装包/report_execute_engine/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp ./target/*tar.gz ~/package/sssia/安装包/report_execute_engine/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
