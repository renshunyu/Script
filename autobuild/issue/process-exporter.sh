#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/process-exporter
cp /home/aiuap/thirdpartytools/monitor/process-exporter/process-exporter-0.6.0.linux-amd64.tar.gz /home/aiuap/package/sssia/安装包/process-exporter/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
