#!bin/sh
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$ANT_HOME/bin:$PATH
svnhome=/home/aiuap/svnproject/program30/program/Uap_Gather_Mysql
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
rm -rf  $buildhome/Uap_Gather_Mysql
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cp -rf $svnhome $buildhome/Uap_Gather_Mysql
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cd $buildhome/Uap_Gather_Mysql
ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"
