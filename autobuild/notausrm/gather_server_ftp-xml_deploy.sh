#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/aiuap30/aiiapc/gather30/ap_gather_server_ftp-xml_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir
cd $deployhome/ap_gather_server_ftp-xml_rm
pwd
#sudo su aiuap30 -c "csh stop.sh ap_gather_server_ftp-xml"
sudo kill -9 $(ps -ef|grep ap_gather_server_ftp-xml_rm|grep -v grep|awk '{print $2}')

while  [ 1 ]
do
result=`ps -ef|grep ap_gather_server_ftp-xml_rm|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止采集完毕"
  break;
fi
echo "正在停止采集，请稍后........"
sleep 1
done



rm -rf $deployhome/ap_gather_server_ftp-xml_rm
result=$?
if [ $result != '0' ]
then
  echo "删除审计平台部署目录错误"
  exit 1
fi
cp $buildhome/ap_gather_server.tar.gz $deployhome
result=$?
if [ $result != '0' ]
then
  echo "拷贝审计平台jar包错误"
  exit 1
fi
cd $deployhome/
pwd
gunzip ap_gather_server.tar.gz
tar -xvf ap_gather_server.tar
mv ap_gather_server ap_gather_server_ftp-xml_rm
rm ap_gather_server.tar
result=$?
if [ $result != '0' ]
then
  echo "解压审计平台jar包错误"
  exit 1
fi
sh $deployhome/initconfig/install.sh
cd $deployhome/ap_gather_server_ftp-xml_rm/
csh start.sh ap_gather_server_ftp-xml_rm
echo $?
echo "采集已经部署成功"
exit 0
