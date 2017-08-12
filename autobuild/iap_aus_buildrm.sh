#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.3.9
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

svnhome=/home/aiuap/svnproject/program30/program/iap_aus_rm/iap_aus/
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "∏¸–¬svnƒø¬º¥ÌŒÛ"
  exit 1
fi


rm -rf  $buildhome/iap_aus_rm


if [ $result != '0' ]
then
  echo "…æ≥˝±‡“Îƒø¬º¥ÌŒÛ"
  exit 1
fi
cp -rf $svnhome $buildhome/iap_aus_rm
result=$?
if [ $result != '0' ]
then
  echo "øΩ±¥ƒø¬º¥ÌŒÛ"
  exit 1
fi
cd $buildhome/iap_aus_rm/$1

mvn clean install -Dmaven.test.skip=true >./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡º≠≥…π¶"
