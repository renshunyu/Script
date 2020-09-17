#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.6.0_31
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
if [[ -z "$1" ]]; then
  echo "��������"
  exit 1
fi

packagepath=/home/aiuap/svnproject/program30rm/fbissue
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/GFort

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi

if [ -d GFort ]; then
  rm -fr GFort
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "ǩ��Ŀ¼����"
  exit 1
fi


cd GFort
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

mkdir -p ~/package/sssia/��װ��/GFort/
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cp ./*tar.gz ~/package/sssia/��װ��/GFort/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ������"
  exit 1
fi