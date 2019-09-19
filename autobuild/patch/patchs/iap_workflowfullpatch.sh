#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.7.0_80
#export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


echo $1
if [ false == $1 ]; then
  echo "取消打包"
  exit 0
fi



patchpath=/home/aiuap/svnproject/program30/release/patch
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/iap_workflow

cd $patchpath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d iap_workflow ]; then
  rm -fr iap_workflow
fi


svn checkout $svnurl -r$3
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd iap_workflow
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

mkdir -p ~/patch/$2/安装包/iap_workflow/xxxxx_yyyymmddhhmi/全量/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp ./iap_workflow_common/target/*tar.gz ~/patch/$2/安装包/iap_workflow/xxxxx_yyyymmddhhmi/全量/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
