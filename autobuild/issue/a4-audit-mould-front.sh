#!bin/sh
buildhome=/home/aiuap/gitprojeck/AISIA/builddir
mkdir -p ~/package/sssia/安装包/a4-audit-mould-front
#cp $buildhome/a4-audit-mould-front/build/libs/mould.war /home/aiuap/hunan_audit/apache-tomcat-8.5.57/webapps
cp $buildhome/a4-audit-mould-front/build/libs/mould.war /home/aiuap/hunan_audit/apache-tomcat-8.5.57/webapps

result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
cd /home/aiuap/hunan_audit/apache-tomcat-8.5.57/bin
sh shutdown.sh
sh startup.sh
#exit 0
