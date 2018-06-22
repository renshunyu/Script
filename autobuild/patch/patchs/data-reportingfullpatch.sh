#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

echo $1
if [ false == $1 ]; then
  echo "取消打包"
  exit 0
fi



patchpath=/home/aiuap/svnproject/program30/release/patch
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/data-reporting

cd $patchpath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d data-reporting ]; then
  rm -fr data-reporting
fi


svn checkout $svnurl -r$3
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd data-reporting
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

mkdir -p ~/patch/$2/安装包/data-reporting/xxxxx_yyyymmddhhmi/全量/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp ./target/*tar.gz ~/patch/$2/安装包/data-reporting/xxxxx_yyyymmddhhmi/全量/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
