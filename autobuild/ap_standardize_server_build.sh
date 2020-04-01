#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.10.7
export PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
svnhome=/home/aiuap/svnproject/program30/program/ap_standardize_server
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
rm -rf  $buildhome/ap_standardize_server $buildhome/ap_standardize_server.tar.gz
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cp -rf $svnhome $buildhome/ap_standardize_server
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cd $buildhome/ap_standardize_server
ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"
