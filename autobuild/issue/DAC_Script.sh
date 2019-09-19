#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/DAC_Script
cp $buildhome/DAC_Script.tar.gz ~/package/sssia/安装包/DAC_Script/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
