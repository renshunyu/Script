#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/安装包/grafana_template
cp /home/aiuap/svnproject/program30/builddir/grafana_template/grafana_template/grafana_template.tar.gz /home/aiuap/package/sssia/安装包/grafana_template/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
