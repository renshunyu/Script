#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap30/iap_device_session_log
buildhome=/home/aiuap/svnproject/program30/builddir/iap_device_session_log
sudo su - aiuap30 -c "cd $deployhome/iap_device_session_log-0.0.1/bin && sh kill.sh "

while  [ 1 ]
do
result=`ps -ef|grep iap_device_session_log-0.0.1|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/iap_device_session_log-0.0.1/bin |wc -l`
if [ $result = '0' ]
then
  echo "stop iap_device_session_log-0.0.1 done"
  break;
fi
echo "stop iap_device_session_log-0.0.1 doing"
sleep 1
done



sudo su - aiuap30 -c "rm -rf $deployhome/iap_device_session_log-0.0.1"
result=$?
if [ $result != '0' ]
then
  echo "删除iap_device_session_log-0.0.1项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cp $buildhome/target/iap_device_session_log-0.0.1-RELEASE.tar.gz $deployhome/"
result=$?
if [ $result != '0' ]
then
  echo "拷贝iap_device_session_log-0.0.1项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/ && tar -zxvf iap_device_session_log-0.0.1-RELEASE.tar.gz && rm iap_device_session_log-0.0.1-RELEASE.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压iap_device_session_log-0.0.1项目错误"
  exit 1
fi
sudo su - aiuap30 -c "sh $deployhome/initconfig/install.sh"
result=$?
if [ $result != '0' ]
then
  echo "拷贝配置文件错误"
  exit 1    
fi          
sudo su - aiuap30 -c "cd $deployhome/iap_device_session_log-0.0.1/bin && sh start.sh"
echo "启动成功"
exit 0
