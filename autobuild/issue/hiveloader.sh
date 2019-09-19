#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/hiveloader
cp $buildhome/hiveloader/target/*.tar.gz ~/package/sssia/安装包/hiveloader/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
