#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.6.0_31
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
if [[ -z "$1" ]]; then
  echo "参数不足"
  exit 1
fi

packagepath=/home/aiuap/svnproject/program30rm/fbissue
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/iap_smp_webservice

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d iap_smp_webservice ]; then
  rm -fr iap_smp_webservice
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd iap_smp_webservice
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi


ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"

mkdir -p ~/package/sssia/安装包/iap_smp_webservice/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp ./target/dist/*.war ~/package/sssia/安装包/iap_smp_webservice/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
