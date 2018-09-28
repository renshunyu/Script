#!/bin/sh

export JAVA_HOME=/usr/java/jdk1.7.0_80
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
if [[ -z "$1" ]]; then
  echo "��������"
  exit 1
fi

packagepath=/home/aiuap/svnproject/program30rm/fbissue
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/iap_server

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi

if [ -d iap_server ]; then
  rm -fr iap_server
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "ǩ��Ŀ¼����"
  exit 1
fi


cd iap_server
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi


ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"

mkdir -p ~/package/sssia/��װ��/iap_server/
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cp ./*.tar.gz ~/package/sssia/��װ��/iap_server/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ������"
  exit 1
fi
