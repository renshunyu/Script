#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.7.0_80/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

deployhome=/home/aiuap/aiuap30/aiiapc/normal_distrabute_excute_engine_rm
buildhome=/home/aiuap/svnproject/program30rm/builddir/normal_distrabute_excute_engine
#cd $deployhome/normal_distrabute_excute_engine/bin

rm -rf $deployhome/normal_distrabute_excute_engine-0.0.1-SNAPSHOT*
result=$?
if [ $result != '0' ]
then
  echo "删除项目错误"
  exit 1
fi
cp $buildhome/target/normal_distrabute_excute_engine-0.0.1-SNAPSHOT-release.tar.gz $deployhome
result=$?
if [ $result != '0' ]
then
  echo "拷贝项目错误"
  exit 1
fi
cd $deployhome/
cd $deployhome/ && tar -zxvf normal_distrabute_excute_engine-0.0.1-SNAPSHOT-release.tar.gz && rm normal_distrabute_excute_engine-0.0.1-SNAPSHOT-release.tar.gz
#sudo su aiuap -c "pwd"
#sudo su aiuap -c "tar -zxvf ap_validate_server-1.0-SNAPSHOT-release.tar.gz"
#sudo su aiuap -c "rm ap_validate_server-1.0-SNAPSHOT-release.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压项目错误"
  exit 1
fi
cd $deployhome/initconfig && sh install.sh
cd $deployhome/normal_distrabute_excute_engine-0.0.1-SNAPSHOT/bin
sh start.sh
echo $?
echo "南研非AUS项目已经部署成功"
exit 0

