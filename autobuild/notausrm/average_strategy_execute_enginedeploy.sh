#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.7.0_80
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH
export PATH

deployhome=/home/aiuap/aiuap30/aiiapc/average_strategy_execute_engine_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/average_strategy_execute_engine
cd $deployhome/average_strategy_execute_engine-1.0/bin

sh stop.sh
#kill -9 `pwdx $(ps -ef|grep jdbc2es-0.0.1-SNAPSHOT|grep -v grep|awk '{print $2}')|grep $deployhome|awk -F: '{print $1}'`
#sudo kill -9 $(ps -ef|grep ap_validate_server)

while  [ 1 ]
do
result=`pwdx $(ps -ef|grep averateStrategy|grep -v grep|awk '{print $2}')|grep $deployhome |wc -l`
if [ $result = '0' ]
then
  echo "停止完毕"
  break;
fi
echo "正在停止，请稍后........"
sleep 1
done

rm -rf $deployhome/average_strategy_execute_engine-1.0
result=$?
if [ $result != '0' ]
then
  echo "删除average_strategy_execute_engine-1.0项目错误"
  exit 1
fi
cp $buildhome/target/average_strategy_execute_engine-1.0.tar.gz $deployhome
result=$?
if [ $result != '0' ]
then
  echo "拷贝average_strategy_execute_engine-1.0项目错误"
  exit 1
fi
cd $deployhome/
pwd
tar -zxvf average_strategy_execute_engine-1.0.tar.gz
rm average_strategy_execute_engine-1.0.tar.gz
result=$?
if [ $result != '0' ]
then
  echo "解压average_strategy_execute_engine-1.0项目错误"
  exit 1
fi


#sudo su aiuap -c "sh $deployhome/jdbc2es-0.0.1-SNAPSHOT/bin/start.sh"
cd $deployhome/initconfig
sh install.sh
result=$?
if [ $result != '0' ]
then
  echo "拷贝配置文件错误"
  exit 1    
fi          
cd $deployhome/average_strategy_execute_engine-1.0/bin
sh start.sh
echo $?
echo "average_strategy_execute_engine-1.0项目已经部署成功"
exit 0
