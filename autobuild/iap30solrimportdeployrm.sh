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
  echo "ֹͣ���ƽ̨���"
  break;
fi
echo "����ֹͣ���ƽ̨�����Ժ�........"
sleep 1
done
rm -rf $deployhome/webapps/solr_data_import
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
mkdir $deployhome/webapps/solr_data_import
if [ $result != '0' ]
then
  echo "�������ƽ̨����Ŀ¼����"
  exit 1
fi
cp /home/aiuap/svnproject/program30rm/builddir/iap_solr_dataimport/target/dist/solr_data_import.war /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/webapps/solr_data_import/
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/webapps/solr_data_import/
jar -xvf /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/webapps/solr_data_import/solr_data_import.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
sh /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/iap_solr_confinit/install.sh
sh /home/aiuap/aiuap30/tomcat_iap_solr_dataimport_rm/bin/startup.sh
echo $?
echo "���ƽ̨�Ѿ�����ɹ�,������seeiap�鿴��̨��־"
