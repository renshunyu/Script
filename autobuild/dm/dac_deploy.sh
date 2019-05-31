#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

#deployhome=/home/aiuap30/data-upload-tools
deployhome=/home/aiuap30/tomcat_dac_dm
buildhome=/home/aiuap/dameng/builddir/kettle
sudo su - aiuap30 -c "cd $deployhome/bin && sh shutdown.sh"

while  [ 1 ]
do
result=`ps -ef|grep tomcat_dac_dm|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/bin |wc -l`
if [ $result = '0' ]
then
  echo "dac停止完毕"
  break;
fi
echo "dac正在停止，请稍后........"
sleep 1
done



sudo su - aiuap30 -c "rm -rf $deployhome/webapps/kettle-server/*"
sudo su - aiuap30 -c "rm -rf $deployhome/webapps/ROOT/*"
result=$?
if [ $result != '0' ]
then
  echo "删除dac项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cp $buildhome/kettle_client/workflow/dist/* $deployhome/webapps/ROOT/ -r"
sudo su - aiuap30 -c "cp $buildhome/kettle-web-assemble/kettle-server/target/kettle-server*.war $deployhome/webapps/kettle-server/kettle-server.war"
result=$?
if [ $result != '0' ]
then
  echo "拷贝dac项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/webapps/kettle-server/ && jar -xvf kettle-server.war && rm kettle-server.war"
result=$?
if [ $result != '0' ]
then
  echo "解压dac项目错误"
  exit 1
fi
sudo su - aiuap30 -c "sh $deployhome/initconfig/install.sh"
result=$?
if [ $result != '0' ]
then
  echo "拷贝配置文件错误"
  exit 1    
fi
sudo su - aiuap30 -c "cd $deployhome/bin && sh startup.sh"          
echo "dac项目已经部署成功"
exit 0
