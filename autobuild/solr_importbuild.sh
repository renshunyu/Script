#!bin/sh
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$ANT_HOME/bin:$PATH
svnhome=/home/aiuap/svnproject/program/program/solr_import/iap_solr_import/
buildhome=/home/aiuap/svnproject/program/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "∏¸–¬svnƒø¬º¥ÌŒÛ"
  exit 1
fi
rm -rf  $buildhome/iap_solr_import
if [ $result != '0' ]
then
  echo "…æ≥˝±‡“Îƒø¬º¥ÌŒÛ"
  exit 1
fi
cp -rf $svnhome $buildhome/iap_solr_import
result=$?
if [ $result != '0' ]
then
  echo "øΩ±¥ƒø¬º¥ÌŒÛ"
  exit 1
fi
cd $buildhome/iap_solr_import
ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡º≠≥…π¶"
