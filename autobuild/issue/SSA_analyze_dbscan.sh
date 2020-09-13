#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/SSA_analyze_dbscan
cp $buildhome/SSA_analyze_dbscan/package/SSA_analyze_dbscan-*.jar ~/package/sssia/安装包/SSA_analyze_dbscan/
cp $buildhome/SSA_analyze_dbscan/package/dbscan.zip ~/package/sssia/安装包/SSA_analyze_dbscan/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
