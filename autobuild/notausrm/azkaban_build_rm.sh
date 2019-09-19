#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
#export M2_HOME=/usr/java/apache-maven-3.2.5
export M2_HOME=/usr/java/apache-maven-3.3.9
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
svnhome=/home/aiuap/svnproject/program30rm/azkaban
buildhome=/home/aiuap/svnproject/program30rm/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "更新svn目录错误"
  exit 1
fi
rm -rf $buildhome/azkaban
if [ $result != '0' ]
then
  echo "删除编译目录错误"
  exit 1
fi
cp -rf $svnhome $buildhome/azkaban
result=$?
if [ $result != '0' ]
then
  echo "拷贝目录错误"
  exit 1
fi
cd $buildhome/azkaban/azkaban
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
