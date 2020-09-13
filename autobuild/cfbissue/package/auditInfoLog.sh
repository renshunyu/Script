#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
if [[ -z "$1" ]]; then
  echo "≤Œ ˝≤ª◊„"
  exit 1
fi

packagepath=/home/aiuap/svnproject/program30rm/fbissue
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/auditInfoLog

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "«–ªªƒø¬º¥ÌŒÛ"
  exit 1
fi

if [ -d auditInfoLog ]; then
  rm -fr auditInfoLog
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "«©≥ˆƒø¬º¥ÌŒÛ"
  exit 1
fi


cd auditInfoLog
result=$?
if [ $result != '0' ]
then
  echo "«–ªªƒø¬º¥ÌŒÛ"
  exit 1
fi


mvn clean install -Dmaven.test.skip=true >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡“Î≥…π¶"

