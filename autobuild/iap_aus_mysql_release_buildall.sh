#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.3.9
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

svnhome=/home/aiuap/svnproject/program30/release/iap_aus
buildhome=/home/aiuap/svnproject/program30/release/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "更新svn目录错误"
  exit 1
fi


rm -rf  $buildhome/iap_aus


if [ $result != '0' ]
then
  echo "删除编译目录错误"
  exit 1
fi
cp -rf $svnhome $buildhome/iap_aus
result=$?
if [ $result != '0' ]
then
  echo "拷贝目录错误"
  exit 1
fi

mkdir -p $buildhome/iap_aus/dp/conf
mkdir -p $buildhome/iap_aus/dp/plugin_iap
mkdir -p $buildhome/iap_aus/dp/plugin_3dr

#exit 0



projects='
standardize/cache-server
iap_aus_event_general
elastic/ori_log_persistence_es
elastic/std_log_persistence_es
ori_log_parser/ori_log_parser_common
ori_log_parser/ori_log_parser_syslog
iap_other_log_persistence_hdfs
std_log_persistence/std_log_persistence_hdfs
std_log_persistence/std_log_persistence_oracle
std_log_persistence/std_log_persistence_mysql
ori_log_persistence_mysql
data_syn_mysql
standardize/standardize-component_mysql
'
for project in ${projects}
do
echo ${project}
cd $buildhome/iap_aus/${project}

mvn clean install package -Dmaven.test.skip=true |tee ./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "${project}编译报错"
  exit 1
fi
echo "${project}编译成功"
cp $buildhome/iap_aus/${project}/package/*.jar $buildhome/iap_aus/dp/plugin_iap
cp $buildhome/iap_aus/${project}/libs/*.jar $buildhome/iap_aus/dp/plugin_3dr
done


project=iap_aus_adapter
cd $buildhome/iap_aus/${project}

mvn clean install -Dmaven.test.skip=true |tee ./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "${project}编译报错"
  exit 1
fi
echo "${project}编译成功"
cp $buildhome/iap_aus/${project}/package/*.jar $buildhome/iap_aus/dp/plugin_iap
cp $buildhome/iap_aus/${project}/libs/*.jar $buildhome/iap_aus/dp/plugin_3dr


echo '所有包编译完成！'

echo '移动配置文件开始。。。'
mkdir -p $buildhome/iap_aus/dp/conf/ori_log_parser_config
mkdir -p $buildhome/iap_aus/dp/conf/ori_log_persistence_config
mkdir -p $buildhome/iap_aus/dp/conf/data_syn_config
mkdir -p $buildhome/iap_aus/dp/conf/standardize_config
mkdir -p $buildhome/iap_aus/dp/conf/std_log_persistence_hdfs_config
mkdir -p $buildhome/iap_aus/dp/conf/std_log_persistence_oracle_config
mkdir -p $buildhome/iap_aus/dp/conf/std_log_persistence_mysql_config
mkdir -p $buildhome/iap_aus/dp/conf/log_persistence_ftp_config
mkdir -p $buildhome/iap_aus/dp/conf/log_persistence_hdfs_config
mkdir -p $buildhome/iap_aus/dp/conf/other_log_persistence_hdfs_config
mkdir -p $buildhome/iap_aus/dp/conf/other_ori_log_persistence_config
mkdir -p $buildhome/iap_aus/dp/conf/ori_log_es_persistence_config
mkdir -p $buildhome/iap_aus/dp/conf/std_log_persistence_es_config


cp  $buildhome/iap_aus/ori_log_parser/ori_log_parser_common/src/main/resources/*.* $buildhome/iap_aus/dp/conf/ori_log_parser_config
cp  $buildhome/iap_aus/ori_log_persistence_mysql/src/main/resources/*.* $buildhome/iap_aus/dp/conf/ori_log_persistence_config
cp  $buildhome/iap_aus/data_syn_mysql/src/main/resources/*.* $buildhome/iap_aus/dp/conf/data_syn_config
cp  $buildhome/iap_aus/standardize/standardize-component_mysql/src/main/resources/*.* $buildhome/iap_aus/dp/conf/standardize_config
cp  $buildhome/iap_aus/std_log_persistence/std_log_persistence_hdfs/src/main/resources/*.* $buildhome/iap_aus/dp/conf/std_log_persistence_hdfs_config
cp  $buildhome/iap_aus/std_log_persistence/std_log_persistence_oracle/src/main/resources/*.* $buildhome/iap_aus/dp/conf/std_log_persistence_oracle_config
cp  $buildhome/iap_aus/std_log_persistence/std_log_persistence_mysql/src/main/resources/*.* $buildhome/iap_aus/dp/conf/std_log_persistence_mysql_config
cp  $buildhome/iap_aus/iap_log_persistence_hdfs/src/main/resources/*.* $buildhome/iap_aus/dp/conf/log_persistence_hdfs_config
cp  $buildhome/iap_aus/iap_other_log_persistence_hdfs/src/main/resources/*.* $buildhome/iap_aus/dp/conf/other_log_persistence_hdfs_config
cp  $buildhome/iap_aus/elastic/ori_log_persistence_es/src/main/resources/*.* $buildhome/iap_aus/dp/conf/ori_log_es_persistence_config
cp  $buildhome/iap_aus/elastic/std_log_persistence_es/src/main/resources/*.* $buildhome/iap_aus/dp/conf/std_log_persistence_es_config

echo '移动配置文件结束。。。'

cd $buildhome/iap_aus/dp/plugin_3dr && rm -f `ls $buildhome/iap_aus/dp/plugin_iap/`
mv $buildhome/iap_aus/dp/plugin_3dr/3des-1.0.jar $buildhome/iap_aus/dp/plugin_iap/
mv $buildhome/iap_aus/dp/plugin_3dr/ap-commons-1.1.jar $buildhome/iap_aus/dp/plugin_iap/
mv $buildhome/iap_aus/dp/plugin_3dr/uap_gather-1.1.jar $buildhome/iap_aus/dp/plugin_iap/
mv $buildhome/iap_aus/dp/plugin_3dr/uapframecore-1.0.jar $buildhome/iap_aus/dp/plugin_iap/
rm -f $buildhome/iap_aus/dp/plugin_3dr/ori_log_persistence-1.0-SNAPSHOT.jar
rm -f $buildhome/iap_aus/dp/plugin_3dr/standardize-component-1.0-SNAPSHOT.jar
rm -f $buildhome/iap_aus/dp/plugin_3dr/data_syn-1.0-SNAPSHOT.jar

cd $buildhome/iap_aus/dp/

tar -zcvf iap_aus_dataprocess.tar.gz plugin_3dr plugin_iap conf
