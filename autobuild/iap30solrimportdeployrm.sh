#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/iap_solr_dataimport
cd $deployhome/bin
#sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_solr_dataimport_rm'|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "停止审计平台完毕"
  break;
fi
echo "正在停止审计平台，请稍后........"
sleep 1
done
rm -rf $deployhome/webapps/solr_data_import
result=$?
if [ $result != '0' ]
then
  echo "删除审计平台部署目录错误"
  exit 1
fi
mkdir $deployhome/webapps/solr_data_import
if [ $result != '0' ]
then
  echo "创建审计平台部署目录错误"
  exit 1
fi
cp /home/aiuap/svnproject/program30rm/builddir/iap_solr_dataimport/target/dist/solr_data_import.war /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/webapps/solr_data_import/
result=$?
if [ $result != '0' ]
then
  echo "拷贝审计平台jar包错误"
  exit 1
fi
cd $deployhome/webapps/solr_data_import/
jar -xvf /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/webapps/solr_data_import/solr_data_import.war
result=$?
if [ $result != '0' ]
then
  echo "解压审计平台jar包错误"
  exit 1
fi
sh /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/iap_solr_confinit/install.sh
sh /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/bin/startup.sh
echo $?
echo "审计平台已经部署成功,请运行seeiap查看后台日志"
