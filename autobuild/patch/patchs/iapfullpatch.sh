#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

echo $1
if [ false == $1 ]; then
  echo "ȡ�����"
  exit 0
fi

patchpath=/home/aiuap/svnproject/program30/release/patch
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/iap

cd $patchpath
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi

if [ -d iap ]; then
  rm -fr iap
fi


svn checkout $svnurl -r$3
result=$?
if [ $result != '0' ]
then
  echo "ǩ��Ŀ¼����"
  exit 1
fi


cd iap
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



mkdir -p ~/patch/$2/��װ��/iap/xxxxx_yyyymmddhhmi/ȫ��/
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cp ./target/dist/iap.war ~/patch/$2/��װ��/iap/xxxxx_yyyymmddhhmi/ȫ��/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ������"
  exit 1
fi
