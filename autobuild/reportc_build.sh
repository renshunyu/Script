#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


svnhome=/home/aiuap/svnproject/program30/program/reportc
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "更新svn目录错误"
  exit 1
fi
echo "更新svn目录成功"
rm -rf  $buildhome/reportc
if [ $result != '0' ]
then
  echo "删除编译目录错误"
  exit 1
fi
cp -rf $svnhome $buildhome/reportc
result=$?
if [ $result != '0' ]
then
  echo "拷贝目录错误"
  exit 1
fi
cd $buildhome/reportc
ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"
