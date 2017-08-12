#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

deployhome=/home/aiuap/aiuap30/aiiapc/gather30/ap_standardize_server_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/ap_standardize_server
cd $deployhome/ap_standardize_server
pwd

kill -9 $(ps -ef|grep ap_standardize_server_rm|grep -v grep|grep -v ap_standardize_server_deploy|awk '{print $2}')

while  [ 1 ]
do
result=`ps -ef|grep ap_standardize_server_rm|grep -v grep|grep -v tail|grep -v ap_standardize_server_deploy|wc -l`
if [ $result = '0' ]
then
  echo "停止标准化完毕"
  break;
fi

echo "正在停止标准化，请稍后........"
sleep 1
done

rm -rf $deployhome/ap_standardize_server_rm
result=$?
if [ $result != '0' ]
then
  echo "删除标准化目录错误"
  exit 1
fi
cp $buildhome/dist/ap_standardize_server.tar.gz $deployhome/ap_standardize_server.tar.gz
result=$?
if [ $result != '0' ]
then
  echo "拷贝标准化包错误"
  exit 1
fi
cd $deployhome/
pwd
tar -zxvf ap_standardize_server.tar.gz
mv ap_standardize_server ap_standardize_server_rm
rm ap_standardize_server.tar.gz
result=$?
if [ $result != '0' ]
then
  echo "解压标准化错误"
  exit 1
fi
cd $deployhome/initconfig/
sh $deployhome/initconfig/install.sh
cd $deployhome/ap_standardize_server_rm/
csh start.sh ap_standardize_server_rm
echo $?
echo "标准化已经部署成功"
exit 0
