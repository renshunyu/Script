#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.7.0_80
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

echo $1
if [ false == $1 ]; then
  echo "ȡ�����"
  exit 0
fi



patchpath=/home/aiuap/svnproject/program30/release/patch
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/reportc

cd $patchpath
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi

if [ -d reportc ]; then
  rm -fr reportc
fi


svn checkout $svnurl -r$3
result=$?
if [ $result != '0' ]
then
  echo "ǩ��Ŀ¼����"
  exit 1
fi


cd reportc
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi


ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"

mkdir -p ~/patch/$2/��װ��/reportc/xxxxx_yyyymmddhhmi/ȫ��/
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cp ./target/dist/reportc.war ~/patch/$2/��װ��/reportc/xxxxx_yyyymmddhhmi/ȫ��/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ������"
  exit 1
fi
