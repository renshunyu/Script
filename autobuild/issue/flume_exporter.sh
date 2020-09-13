#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/flume_exporter
cp /home/aiuap/thirdpartytools/monitor/flume_exporter/flume_exporter-0.0.2.tar.gz /home/aiuap/package/sssia/安装包/flume_exporter/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
