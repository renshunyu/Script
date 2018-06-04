#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap30/ap_validate_server
buildhome=/home/aiuap/svnproject/program30/builddir/ap_validate_server
cd $deployhome/ap_validate_server-1.0-SNAPSHOT/bin
#sudo su aiuap -c "pwd"
sudo su aiuap30 -c "sh stop.sh"
#sudo kill -9 $(ps -ef|grep ap_validate_server)

while  [ 1 ]
do
result=`ps -ef|ap_validate_server|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止完毕"
  break;
fi
echo "正在停止，请稍后........"
sleep 1
done



sudo su aiuap30 -c "rm -rf $deployhome/ap_validate_server-1.0-SNAPSHOT"
result=$?
if [ $result != '0' ]
then
  echo "删除南研稽核错误"
  exit 1
fi
sudo su aiuap30 -c "cp /home/aiuap/svnproject/program30/builddir/ap_validate_server/target/ap_validate_server-1.0-SNAPSHOT-release.tar.gz $deployhome"
result=$?
if [ $result != '0' ]
then
  echo "拷贝南研稽核项目错误"
  exit 1
fi
#cd $deployhome/
sudo su aiuap30 -c "cd $deployhome/ && tar -zxvf ap_validate_server-1.0-SNAPSHOT-release.tar.gz && rm ap_validate_server-1.0-SNAPSHOT-release.tar.gz"
#sudo su aiuap -c "tar -zxvf ap_validate_server-1.0-SNAPSHOT-release.tar.gz"
#sudo su aiuap -c "rm ap_validate_server-1.0-SNAPSHOT-release.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压南研稽核项目错误"
  exit 1
fi
#sudo su aiuap -c "sh $deployhome/ap_validate_server-1.0-SNAPSHOT/bin/start.sh"
#cp -rf $deployhome/application.yml $deployhome/ap_validate_server-1.0-SNAPSHOT/config/application.yml
result=$?
if [ $result != '0' ]
then
  echo "拷贝配置文件错误"
  exit 1    
fi          
#cd $deployhome/ap_validate_server-1.0-SNAPSHOT/bin/
#sudo su aiuap -c "sh start.sh"
#echo $?
#echo "南研非AUS项目已经部署成功"
exit 0
