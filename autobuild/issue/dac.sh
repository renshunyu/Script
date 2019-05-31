#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

cp $buildhome/kettle/kettle_client/workflow/dist  $buildhome/kettle/kettle-web-assemble/kettle-server/target/ROOT -r
cd $buildhome/kettle/kettle-web-assemble/kettle-server/target/
tar -zcvf dac.tar.gz kettle-server.war ROOT

mkdir -p ~/package/sssia/安装包/dac
cp $buildhome/kettle/kettle-web-assemble/kettle-server/target/dac.tar.gz ~/package/sssia/安装包/dac/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
