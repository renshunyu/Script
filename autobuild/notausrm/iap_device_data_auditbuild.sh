#!bin/sh
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
svnhome=/home/aiuap/svnproject/program30rm/iap_device_date_audit
buildhome=/home/aiuap/svnproject/program30rm/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "更新svn目录错误"
  exit 1
fi
echo "更新svn目录成功"
rm -rf  $buildhome/iap_device_date_audit
if [ $result != '0' ]
then
  echo "删除编译目录错误"
  exit 1
fi
cp -rf $svnhome $buildhome/iap_device_date_audit
result=$?
if [ $result != '0' ]
then
  echo "拷贝目录错误"
  exit 1
fi
cd $buildhome/iap_device_date_audit
ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"
