#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.10.7
export PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

deployhome=/home/aiuap30/gather30/ap_standardize_server
buildhome=/home/aiuap/svnproject/program30/builddir/ap_standardize_server
#cd $deployhome/ap_standardize_server
#sudo su aiuap30 -c "pwd"

sudo kill -9 $(sudo pwdx `ps -ef|grep ap_standardize_server|grep -v grep|awk '{print $2}'`|grep $deployhome/ap_standardize_server|awk -F: '{print $1}')

while  [ 1 ]
do
result=$(sudo pwdx `ps -ef|grep ap_standardize_server|grep -v grep|awk '{print $2}'`|grep $deployhome/ap_standardize_server|wc -l)
if [ $result = '0' ]
then
  echo "停止标准化完毕"
  break;
fi

echo "正在停止标准化，请稍后........"
sleep 1
done

sudo su aiuap30 -c "rm -rf $deployhome/ap_standardize_server"
result=$?
if [ $result != '0' ]
then
  echo "删除标准化目录错误"
  exit 1
fi
sudo su aiuap30 -c "cp $buildhome/dist/ap_standardize_server.tar.gz $deployhome/ap_standardize_server.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "拷贝标准化包错误"
  exit 1
fi
#exit 0
cd $deployhome/
sudo su aiuap30 -c "pwd"
sudo su aiuap30 -c "tar -zxvf ap_standardize_server.tar.gz"
sudo su aiuap30 -c "rm ap_standardize_server.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压标准化错误"
  exit 1
fi
cd $deployhome/initconfig/
sudo su aiuap30 -c "sh $deployhome/initconfig/install.sh"
cd $deployhome/ap_standardize_server/
sudo su - aiuap30 -c "cd $deployhome/ap_standardize_server/ && csh start.sh ap_standardize_server"
echo $?
echo "标准化已经部署成功"
exit 0
