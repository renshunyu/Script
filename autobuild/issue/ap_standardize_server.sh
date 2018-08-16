#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/ap_standardize_server
cp $buildhome/ap_standardize_server/dist/*.tar.gz ~/package/sssia/安装包/ap_standardize_server/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
