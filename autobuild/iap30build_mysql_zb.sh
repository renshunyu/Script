#!bin/sh
#export JAVA_HOME=/usr/java/jdk1.6.0_31
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/aisiamv04r06c00_20190111/iap_mysql
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
echo "����svnĿ¼�ɹ�"
rm -rf  $buildhome/iap_mysql
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cd $buildhome/
svn checkout $svnhome
#cp -rf $svnhome $buildhome/iap_mysql
#result=$?
#if [ $result != '0' ]
#then
#  echo "����Ŀ¼����"
#  exit 1
#fi
#cd $buildhome/iap_mysql
ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"
