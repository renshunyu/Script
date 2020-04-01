#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap30/realtime_standardize_server
buildhome=/home/aiuap/svnproject/program30/builddir/realtime_standardize_server
sudo su - aiuap30 -c "cd $deployhome/realtime_standardize_server-0.0.1/bin && sh kill.sh "

while  [ 1 ]
do
result=`ps -ef|grep realtime_standardize_server|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/realtime_standardize_server-0.0.1/bin |wc -l`
if [ $result = '0' ]
then
  echo "stop realtime_standardize_server done"
  break;
fi
echo "stop realtime_standardize_server doing"
sleep 1
done



sudo su - aiuap30 -c "rm -rf $deployhome/realtime_standardize_server-0.0.1"
result=$?
if [ $result != '0' ]
then
  echo "删除realtime_standardize_server-0.0.1项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cp $buildhome/target/realtime_standardize_server-0.0.1-RELEASE.tar.gz $deployhome/"
result=$?
if [ $result != '0' ]
then
  echo "拷贝realtime_standardize_server项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/ && tar -zxvf realtime_standardize_server-0.0.1-RELEASE.tar.gz && rm realtime_standardize_server-0.0.1-RELEASE.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压realtime_standardize_server-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
sudo su - aiuap30 -c "sh $deployhome/initconfig/install.sh"
result=$?
if [ $result != '0' ]
then
  echo "拷贝配置文件错误"
  exit 1    
fi          
sudo su - aiuap30 -c "cd $deployhome/realtime_standardize_server-0.0.1/bin && sh start.sh"
exit 0
