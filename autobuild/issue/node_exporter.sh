#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/node_exporter
cp /home/aiuap/thirdpartytools/monitor/node_exporter/node_exporter-0.18.1.linux-amd64.tar.gz /home/aiuap/package/sssia/安装包/node_exporter/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
