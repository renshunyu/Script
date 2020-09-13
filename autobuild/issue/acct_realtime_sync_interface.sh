#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/acct_realtime_sync_interface
cp $buildhome/acct_realtime_sync_interface/target/*tar.gz ~/package/sssia/安装包/acct_realtime_sync_interface/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
