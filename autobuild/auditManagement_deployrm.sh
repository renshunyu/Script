#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap/aiuap30/aiiapc/viewServer
buildhome=/home/aiuap/svnproject/program30rm/builddir/auditManagement
cd $deployhome/viewServer-0.0.1-SNAPSHOT/bin && sh kill.sh

while  [ 1 ]
do
result=`ps -ef|grep viewServer|grep -v grep|awk '{print $2}'|sudo pwdx|grep $deployhome/viewServer-0.0.1-SNAPSHOT/bin |wc -l`
if [ $result = '0' ]
then
  echo "stop viewServer done"
  break;
fi
echo "stop viewServer doing"
sleep 1
done



rm -rf $deployhome/viewServer-0.0.1-SNAPSHOT
result=$?
if [ $result != '0' ]
then
  echo "删除viewServer-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
cp $buildhome/viewServer/target/viewServer-0.0.1-SNAPSHOT-RELEASE.tar.gz $deployhome/
result=$?
if [ $result != '0' ]
then
  echo "拷贝viewServer-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
cd $deployhome/ && tar -zxvf viewServer-0.0.1-SNAPSHOT-RELEASE.tar.gz && rm viewServer-0.0.1-SNAPSHOT-RELEASE.tar.gz
result=$?
if [ $result != '0' ]
then
  echo "解压viewServer-0.0.1-SNAPSHOT项目错误"
  exit 1
fi
sh $deployhome/initconfig/install.sh
result=$?
if [ $result != '0' ]
then
  echo "拷贝配置文件错误"
  exit 1    
fi          
cd $deployhome/viewServer-0.0.1-SNAPSHOT/bin && sh start.sh
result=$?
echo "data-upload-tools-0.0.1-SNAPSHOT项目已经部署成功"
exit 0
