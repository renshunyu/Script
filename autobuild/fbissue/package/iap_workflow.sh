#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.7.0_80
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
if [[ -z "$1" ]]; then
  echo "��������"
  exit 1
fi

packagepath=/home/aiuap/svnproject/program30rm/fbissue
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/iap_workflow

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi

if [ -d iap_workflow ]; then
  rm -fr iap_workflow
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "ǩ��Ŀ¼����"
  exit 1
fi


cd iap_workflow
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi


mvn clean package -Dmaven.test.skip=true >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"

mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_common/
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cp ./iap_workflow_common/target/*tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_common/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ������"
  exit 1
fi
#mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_anhui/
#result=$?
#if [ $result != '0' ]
#then
#  echo "����Ŀ¼����"
#  exit 1
#fi
#cp ./iap_workflow_anhui/target/*tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_anhui/
#result=$?
#if [ $result != '0' ]
#then
#  echo "���ư�װ������"
#  exit 1
#fi

#mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_shanghai/
#result=$?
#if [ $result != '0' ]
#then
#  echo "����Ŀ¼����"
#  exit 1
#fi
#cp ./iap_workflow_shanghai/target/*tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_shanghai/
#result=$?
#if [ $result != '0' ]
#then
#  echo "���ư�װ������"
#  exit 1
#fi

#mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_shanxi/
#result=$?
#if [ $result != '0' ]
#then
#  echo "����Ŀ¼����"
#  exit 1
#fi
#cp ./iap_workflow_shanxi/target/*tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_shanxi/
#result=$?
#if [ $result != '0' ]
#then
#  echo "���ư�װ������"
#  exit 1
#fi

#mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_henan/
#result=$?
#if [ $result != '0' ]
#then
#  echo "����Ŀ¼����"
#  exit 1
#fi
#cp ./iap_workflow_henan/target/*tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_henan/
#result=$?
#if [ $result != '0' ]
#then
#  echo "���ư�װ������"
#  exit 1
#fi
