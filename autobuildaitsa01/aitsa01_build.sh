#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

svnhome=/home/aiuap/svnproject/aitsa01/program
buildhome=/home/aiuap/svnproject/aitsa01/program/builddir

svn up $svnhome/$1
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi


rm -rf  $buildhome/$1


if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cp -rf $svnhome/$1 $buildhome/$1
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cd $buildhome/$1

mvn package -Dmaven.test.skip=true >./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"
