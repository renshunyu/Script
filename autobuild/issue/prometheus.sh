#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/prometheus
cp /home/aiuap/thirdpartytools/monitor/prometheus/prometheus.zip /home/aiuap/package/sssia/安装包/prometheus/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
