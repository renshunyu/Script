#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/jasypt-tool
cp $buildhome/jasypt-tool/target/*.jar ~/package/sssia/安装包/jasypt-tool/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
