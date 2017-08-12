#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#deployhome=/home/aiuap/aiuap30/tomcat_iap_rm
deployhome=/home/aiuap/aiuap30/tomcat_iap_increment
buildhome=/home/aiuap/svnproject/release/builddir/iap
cd $deployhome/bin
sh shutdown.sh >/dev/null
ps -ef|grep 'tomcat_iap_increment/'|grep -v grep |grep -v tail |awk '{print $2}'|xargs kill -9 
while  [ 1 ]
do
result=`ps -ef|grep /home/aiuap/aiuap30/tomcat_iap_increment/|grep -v grep|grep -v tail |wc -l`
if [ $result = '0' ]
then
  echo "ֹͣ���ƽ̨���"
  break;
fi
echo "����ֹͣ���ƽ̨�����Ժ�........"
sleep 1
done
#rm -rf $deployhome/webapps/iap
rm -rf $deployhome/webapps/iap
result=$?
if [ $result != '0' ]
then
  echo "ɾ�����ƽ̨����Ŀ¼����"
  exit 1
fi
mkdir $deployhome/webapps/iap
if [ $result != '0' ]
then
  echo "�������ƽ̨����Ŀ¼����"
  exit 1
fi
cp $buildhome/target/dist/iap.war $deployhome/webapps/iap/iap.war
result=$?
if [ $result != '0' ]
then
  echo "�������ƽ̨jar������"
  exit 1
fi
cd $deployhome/webapps/iap/
jar -xvf $deployhome/webapps/iap/iap.war
result=$?
if [ $result != '0' ]
then
  echo "��ѹ���ƽ̨jar������"
  exit 1
fi
sh $deployhome/iapconfinit/install.sh
sh $deployhome/bin/startup.sh
echo $?
echo "���ƽ̨�Ѿ�����ɹ�,������seeiap�鿴��̨��־"
