#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.7.0_80
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

#deployhome=/home/aiuap30/data-upload-tools
deployhome=/home/aiuap30/tomcat_reportcs
buildhome=/home/aiuap/svnproject/program30/builddir
sudo su - aiuap30 -c "cd $deployhome/bin && sh shutdown.sh"

while  [ 1 ]
do
result=`ps -ef|grep tomcat_reportcs|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/bin |wc -l`
if [ $result = '0' ]
then
  echo "data-monitor停止完毕"
  break;
fi
echo "data-monitor正在停止，请稍后........"
sleep 1
done



sudo su - aiuap30 -c "rm -rf $deployhome/webapps/reportc/*"
sudo su - aiuap30 -c "rm -rf $deployhome/webapps/reports/*"
result=$?
if [ $result != '0' ]
then
  echo "删除report项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cp $buildhome/reportc/target/dist/reportc.war $deployhome/webapps/reportc/"
sudo su - aiuap30 -c "cp $buildhome/reports/target/reports.war $deployhome/webapps/reports/"
result=$?
if [ $result != '0' ]
then
  echo "拷贝report项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/webapps/reportc/ && jar -xvf reportc.war && rm reportc.war"
sudo su - aiuap30 -c "cd $deployhome/webapps/reports/ && jar -xvf reports.war && rm reports.war"
result=$?
if [ $result != '0' ]
then
  echo "解压report项目错误"
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
echo "report项目已经部署成功"
exit 0
