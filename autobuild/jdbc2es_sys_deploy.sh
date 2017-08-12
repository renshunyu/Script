#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap/zjy/jdbc2es-sys
buildhome=/home/aiuap/svnproject/program30/builddir/jdbc2es
cd $deployhome/jdbc2es-0.0.1-SNAPSHOT/bin
#sudo su aiuap -c "pwd"
sudo su aiuap -c "sh stop.sh"
#sudo kill -9 $(ps -ef|grep ap_validate_server)

while  [ 1 ]
do
result=`ps -ef|jdbc2es-0.0.1-SNAPSHOT|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止完毕"
  break;
fi
echo "正在停止，请稍后........"
sleep 1
done



sudo su aiuap -c "rm -rf $deployhome/jdbc2es-0.0.1-SNAPSHOT"
result=$?
if [ $result != '0' ]
then
  echo "删除jdbc2es-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
sudo su aiuap -c "cp /home/aiuap/svnproject/program30/builddir/jdbc2es/target/jdbc2es-0.0.1-SNAPSHOT-release.tar.gz /home/aiuap/zjy/jdbc2es-sys"
result=$?
if [ $result != '0' ]
then
  echo "拷贝jdbc2es-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
cd $deployhome/
sudo su aiuap -c "pwd"
sudo su aiuap -c "tar -zxvf jdbc2es-0.0.1-SNAPSHOT-release.tar.gz"
sudo su aiuap -c "rm jdbc2es-0.0.1-SNAPSHOT-release.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压jdbc2es-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
#sudo su aiuap -c "sh $deployhome/jdbc2es-0.0.1-SNAPSHOT/bin/start.sh"
cp -rf $deployhome/initconfig/application.yml $deployhome/jdbc2es-0.0.1-SNAPSHOT/config/application.yml
result=$?
if [ $result != '0' ]
then
  echo "拷贝配置文件错误"
  exit 1    
fi          
cd $deployhome/jdbc2es-0.0.1-SNAPSHOT/bin/
sudo su aiuap -c "sh start.sh"
echo $?
echo "jdbc2es-0.0.1-SNAPSHOT项目已经部署成功"
exit 0
