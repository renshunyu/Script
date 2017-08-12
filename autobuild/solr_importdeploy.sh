#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/ jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/ jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/tomcat_iap_solr_import
buildhome=/home/aiuap/svnproject/program/builddir/iap_solr_import
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep tomcat_iap_solr_import|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/tomcat_iap_solr_import/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止solr增量服务完毕"
  break;
fi
echo "正在停止，请稍后........"
sleep 1
done
rm -rf $deployhome/webapps/solr_data_import
result=$?
if [ $result != '0' ]
then
  echo "删除solr增量服务部署目录错误"
  exit 1
fi
mkdir $deployhome/webapps/solr_data_import
if [ $result != '0' ]
then
  echo "创建solr增量服务部署目录错误"
  exit 1
fi
cp $buildhome/target/dist/solr_data_import.war  $deployhome/webapps/solr_data_import/solr_data_import.war
result=$?
if [ $result != '0' ]
then
  echo "拷贝solr增量服务jar包错误"
  exit 1
fi
cd $deployhome/webapps/solr_data_import
jar -xvf $deployhome/webapps/solr_data_import/solr_data_import.war
result=$?
if [ $result != '0' ]
then
  echo "解压solr增量服务jar包错误"
  exit 1
fi
sh  $deployhome/iap_solr_confinit/install.sh
sudo su - aiuap30 -c "sh $deployhome/bin/startup.sh"
echo $?
echo "solr增量服务已经部署成功,请运行seesolrimport查看后台日志"
