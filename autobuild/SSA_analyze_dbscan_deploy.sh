#!/bin/bash
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.8.0_121/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:$M2_HOME/bin:
export PATH

#deployhome=/home/aiuap30/data-upload-tools
deployhome=/home/aiuap30/filecollector
buildhome=/home/aiuap/svnproject/program30/builddir/SSA_analyze_dbscan
sudo su - aiuap30 -c "cd $deployhome//filecollector-0.0.1/bin && sh stop.sh"


sudo su - aiuap30 -c "rm -rf $deployhome/filecollector-0.0.1-RELEASE.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "删除filecollector-0.0.1-RELEASE.tar.gz项目错误"
  exit 1
fi

sudo su - aiuap30 -c "rm -rf $deployhome/filecollector-0.0.1"
result=$?
if [ $result != '0' ]
then
  echo "删除filecollector-0.0.1项目错误"
  exit 1
fi

sudo su - aiuap30 -c "cp $buildhome/target/filecollector-0.0.1-RELEASE.tar.gz $deployhome/"
result=$?
if [ $result != '0' ]
then
  echo "拷贝filecollector-0.0.1-RELEASE.tar.gz项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/ && tar -zxvf filecollector-0.0.1-RELEASE.tar.gz"
result=$?
if [ $result != '0' ]
then
  echo "解压filecollector-0.0.1-RELEASE.tar.gz项目错误"
  exit 1
fi
sudo su - aiuap30 -c "cd $deployhome/filecollector-0.0.1/bin/ && sh start.sh"
echo "filecollector-0.0.1-RELEASE.tar.gz项目已经部署成功"
#exit 0
