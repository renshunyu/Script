#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/program/acct_realtime_sync_interface
buildhome=/home/aiuap/svnproject/program30/builddir



rm -rf  $buildhome/acct_realtime_sync_interface

cd $buildhome

if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi

svn co $svnhome


result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi

cd $buildhome/acct_realtime_sync_interface

svn update $svnhome

mvn clean package -Dmaven.test.skip=true >./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"
