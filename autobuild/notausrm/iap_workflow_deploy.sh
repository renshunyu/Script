#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.7.0_80
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap/aiuap30/aiiapc/iap_workflow_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/iap_workflow
cd $deployhome/jdbc2es-0.0.1-SNAPSHOT/bin

#sh stop.sh
kill -9 `pwdx $(ps -ef|grep jdbc2es-0.0.1-SNAPSHOT|grep -v grep|awk '{print $2}')|grep $deployhome|awk -F: '{print $1}'`
#sudo kill -9 $(ps -ef|grep ap_validate_server)

while  [ 1 ]
do
result=`pwdx $(ps -ef|grep jdbc2es-0.0.1-SNAPSHOT|grep -v grep|awk '{print $2}')|grep $deployhome |wc -l`
if [ $result = '0' ]
then
  echo "停止完毕"
  break;
fi
echo "正在停止，请稍后........"
sleep 1
done

rm -rf $deployhome/jdbc2es-0.0.1-SNAPSHOT
result=$?
if [ $result != '0' ]
then
  echo "删除jdbc2es-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
cp $buildhome/target/jdbc2es-0.0.1-SNAPSHOT-release.tar.gz $deployhome
result=$?
if [ $result != '0' ]
then
  echo "拷贝jdbc2es-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
cd $deployhome/
pwd
tar -zxvf jdbc2es-0.0.1-SNAPSHOT-release.tar.gz
rm jdbc2es-0.0.1-SNAPSHOT-release.tar.gz
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
sh start.sh
echo $?
echo "jdbc2es-0.0.1-SNAPSHOT项目已经部署成功"
exit 0
