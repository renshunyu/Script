#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


packagepath=/home/aiuap/svnproject/program30/builddir
svnurl=/home/aiuap/svnproject/program30/program/reports
svn up $svnurl
cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "«–ªªƒø¬º¥ÌŒÛ"
  exit 1
fi

if [ -d reports ]; then
  rm -fr reports
fi


cp -rf $svnurl $packagepath/reports
result=$?
if [ $result != '0' ]
then
  echo "«©≥ˆƒø¬º¥ÌŒÛ"
  exit 1
fi



cd reports
result=$?
if [ $result != '0' ]
then
  echo "«–ªªƒø¬º¥ÌŒÛ"
  exit 1
fi


mvn clean package -Dmaven.test.skip=true >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡“Î≥…π¶"
