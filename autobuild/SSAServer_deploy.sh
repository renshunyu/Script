#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap30/tomcat_ssa_server
buildhome=/home/aiuap/svnproject/program30/builddir/SSAServer
cd $deployhome/bin
sh shutdown.sh >/dev/null

ps -ef|grep 'tomcat_ssa_server/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs sudo kill -9
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap30/tomcat_ssa_server/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止江西电信大数据平台完毕"
  break;
fi
echo "正在停止江西电信大数据平台，请稍后........"
sleep 1
done
sudo rm -rf $deployhome/webapps/SSAServer
result=$?
if [ $result != '0' ]
then
  echo "删除江西电信大数据平台部署目录错误"
  exit 1
fi
#sudo mkdir $deployhome/webapps/iap
sudo su aiuap30 -c "mkdir $deployhome/webapps/SSAServer"
if [ $result != '0' ]
then
  echo "创建江西电信大数据平台部署目录错误"
  exit 1
fi
sudo su aiuap30 -c "cp /home/aiuap/svnproject/program30/builddir/SSAServer/SSAServer/target/SSAServer-new/SSAServer.war /home/aiuap30/tomcat_ssa_server/webapps/SSAServer/SSAServer.war"
result=$?
if [ $result != '0' ]
then
  echo "拷贝江西电信大数据平台war包错误"
  exit 1
fi
cd $deployhome/webapps/SSAServer/
#sudo  jar -xvf /home/aiuap30/tomcat_iap30/webapps/iap/iap.war
sudo su aiuap30 -c "jar -xvf /home/aiuap30/tomcat_ssa_server/webapps/SSAServer/SSAServer.war"
result=$?
if [ $result != '0' ]
then
  echo "解压江西电信大数据平台war包错误"
  exit 1
fi

sudo su aiuap30 -c "sh /home/aiuap30/tomcat_ssa_server/initconfig/install.sh"
#sudo chgrp -R aiuap iap
#sudo chown -R aiuap30 iap
sudo su aiuap30 -c "sh /home/aiuap30/tomcat_ssa_server/bin/startup.sh"
#sudo chmod 777 /home/aiuap30/tomcat_ssa_server/webapps/iap/download
echo $?
echo "江西电信大数据平台已经部署成功"