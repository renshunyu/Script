#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


packagepath=/home/aiuap/svnproject/program30/builddir
svnurl=/home/aiuap/svnproject/program30/program/reportc
svn up $svnurl
cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "«–ªªƒø¬º¥ÌŒÛ"
  exit 1
fi

if [ -d reportc ]; then
  rm -fr reportc
fi


cp -rf $svnurl $packagepath/reportc
result=$?
if [ $result != '0' ]
then
  echo "«©≥ˆƒø¬º¥ÌŒÛ"
  exit 1
fi


cd reportc
result=$?
if [ $result != '0' ]
then
  echo "«–ªªƒø¬º¥ÌŒÛ"
  exit 1
fi

svn update 

ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡“Î≥…π¶"

