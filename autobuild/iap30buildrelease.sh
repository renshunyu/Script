#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
#svnpro=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/aiiapv03r04c00_20150122/iap
svnhome=/home/aiuap/svnproject/release/iap
buildhome=/home/aiuap/svnproject/release/builddir
#cd /home/aiuap/svnproject/release
#svn co $svnpro
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "∏¸–¬svnƒø¬º¥ÌŒÛ"
  exit 1
fi
rm -rf  $buildhome/iap
if [ $result != '0' ]
then
  echo "…æ≥˝±‡“Îƒø¬º¥ÌŒÛ"
  exit 1
fi
cp -rf $svnhome $buildhome/iap
result=$?
if [ $result != '0' ]
then
  echo "øΩ±¥ƒø¬º¥ÌŒÛ"
  exit 1
fi
cd $buildhome/iap
ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡“Î≥…π¶"
