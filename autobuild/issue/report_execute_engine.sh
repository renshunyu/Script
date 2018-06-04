#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/report_execute_engine
cp $buildhome/report_execute_engine/target/*tar.gz ~/package/sssia/安装包/report_execute_engine/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
