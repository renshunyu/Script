#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

echo $1
if [ false == $1 ]; then
  echo "取消打包"
  exit 0
fi

patchpath=/home/aiuap/svnproject/program30/release/patch
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/azkaban/azkaban

cd $patchpath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d azkaban ]; then
  rm -fr azkaban
fi


svn checkout $svnurl -r$3
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd azkaban
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

#打子包
gradle build >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"
#打总包
gradle build >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"



mkdir -p ~/patch/$2/安装包/azkaban/xxxxx_yyyymmddhhmi/全量/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp ./build/distributions/*.tar.gz ~/patch/$2/安装包/azkaban/xxxxx_yyyymmddhhmi/全量/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
