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
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/data-monitor

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d data-monitor ]; then
  rm -fr data-monitor
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd data-monitor
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d ./web/report-to-monitoring ]
then
  cd ./web/report-to-monitoring
  npm install
  result=$?
  if [ $result != '0' ]
  then
    echo "下载依赖错误"
    exit 1
  fi
  npm run build
  result=$?
  if [ $result != '0' ]
  then
    echo "前台打包错误"
    exit 1
  fi
  cd ../../

fi 

mvn clean package -Dmaven.test.skip=true >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"

mkdir -p ~/package/sssia/安装包/data-monitor/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp ./target/*tar.gz ~/package/sssia/安装包/data-monitor/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
