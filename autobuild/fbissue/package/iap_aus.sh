#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.3.9
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
if [[ -z "$1" ]]; then
  echo "参数不足"
  exit 1
fi

packagepath=/home/aiuap/svnproject/program30rm/fbissue
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/iap_aus

cd $packagepath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d iap_aus ]; then
  rm -fr iap_aus
fi


svn checkout $svnurl
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd iap_aus
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

mkdir -p $packagepath/iap_aus/dp/conf
mkdir -p $packagepath/iap_aus/dp/plugin_iap
mkdir -p $packagepath/iap_aus/dp/plugin_3dr

#exit 0


project=iap_aus_adapter
cd $packagepath/iap_aus/${project}

mvn clean install -Dmaven.test.skip=true |tee ./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "${project}编译报错"
  exit 1
fi
echo "${project}编译成功"
cp $packagepath/iap_aus/${project}/package/*.jar $packagepath/iap_aus/dp/plugin_iap
cp $packagepath/iap_aus/${project}/libs/*.jar $packagepath/iap_aus/dp/plugin_3dr

projects='
standardize/cache-server
iap_aus_event_general
elastic/ori_log_persistence_es
elastic/std_log_persistence_es
iap_aus_verification
ori_log_parser/ori_log_parser_common
ori_log_parser/ori_log_parser_syslog
iap_other_log_persistence_hdfs
std_log_persistence/std_log_persistence_hdfs
std_log_persistence/std_log_persistence_oracle
iap_other_ori_log_persistence
ori_log_persistence
standardize/standardize-component
data_syn
'
for project in ${projects}
do
echo ${project}
cd $packagepath/iap_aus/${project}

mvn clean package -Dmaven.test.skip=true |tee ./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "${project}编译报错"
  exit 1
fi
echo "${project}编译成功"
cp $packagepath/iap_aus/${project}/package/*.jar $packagepath/iap_aus/dp/plugin_iap
cp $packagepath/iap_aus/${project}/libs/*.jar $packagepath/iap_aus/dp/plugin_3dr
done
echo '所有包编译完成！'

echo '移动配置文件开始。。。'
mkdir -p $packagepath/iap_aus/dp/conf/ori_log_parser_config
mkdir -p $packagepath/iap_aus/dp/conf/ori_log_persistence_config
mkdir -p $packagepath/iap_aus/dp/conf/data_syn_config
mkdir -p $packagepath/iap_aus/dp/conf/standardize_config
mkdir -p $packagepath/iap_aus/dp/conf/std_log_persistence_hdfs_config
mkdir -p $packagepath/iap_aus/dp/conf/std_log_persistence_oracle_config
mkdir -p $packagepath/iap_aus/dp/conf/ori_log_verification_config
mkdir -p $packagepath/iap_aus/dp/conf/log_persistence_ftp_config
mkdir -p $packagepath/iap_aus/dp/conf/log_persistence_hdfs_config
mkdir -p $packagepath/iap_aus/dp/conf/other_log_persistence_hdfs_config
mkdir -p $packagepath/iap_aus/dp/conf/other_ori_log_persistence_config
mkdir -p $packagepath/iap_aus/dp/conf/ori_log_es_persistence_config
mkdir -p $packagepath/iap_aus/dp/conf/std_log_persistence_es_config


cp  $packagepath/iap_aus/ori_log_parser/ori_log_parser_common/src/main/resources/*.* $packagepath/iap_aus/dp/conf/ori_log_parser_config
cp  $packagepath/iap_aus/ori_log_persistence/src/main/resources/*.* $packagepath/iap_aus/dp/conf/ori_log_persistence_config
cp  $packagepath/iap_aus/data_syn/src/main/resources/*.* $packagepath/iap_aus/dp/conf/data_syn_config
cp  $packagepath/iap_aus/standardize/standardize-component/src/main/resources/*.* $packagepath/iap_aus/dp/conf/standardize_config
cp  $packagepath/iap_aus/std_log_persistence/std_log_persistence_hdfs/src/main/resources/*.* $packagepath/iap_aus/dp/conf/std_log_persistence_hdfs_config
cp  $packagepath/iap_aus/std_log_persistence/std_log_persistence_oracle/src/main/resources/*.* $packagepath/iap_aus/dp/conf/std_log_persistence_oracle_config
cp  $packagepath/iap_aus/iap_aus_verification/src/main/resources/*.* $packagepath/iap_aus/dp/conf/ori_log_verification_config
cp  $packagepath/iap_aus/iap_log_persistence_ftp/src/main/resources/*.* $packagepath/iap_aus/dp/conf/log_persistence_ftp_config
cp  $packagepath/iap_aus/iap_log_persistence_hdfs/src/main/resources/*.* $packagepath/iap_aus/dp/conf/log_persistence_hdfs_config
cp  $packagepath/iap_aus/iap_other_log_persistence_hdfs/src/main/resources/*.* $packagepath/iap_aus/dp/conf/other_log_persistence_hdfs_config
cp  $packagepath/iap_aus/iap_other_ori_log_persistence/src/main/resources/*.* $packagepath/iap_aus/dp/conf/other_ori_log_persistence_config
cp  $packagepath/iap_aus/elastic/ori_log_persistence_es/src/main/resources/*.* $packagepath/iap_aus/dp/conf/ori_log_es_persistence_config
cp  $packagepath/iap_aus/elastic/std_log_persistence_es/src/main/resources/*.* $packagepath/iap_aus/dp/conf/std_log_persistence_es_config

echo '移动配置文件结束。。。'

cd $packagepath/iap_aus/dp/plugin_3dr && rm -f `ls $packagepath/iap_aus/dp/plugin_iap/`
mv $packagepath/iap_aus/dp/plugin_3dr/3des-1.0.jar $packagepath/iap_aus/dp/plugin_iap/
mv $packagepath/iap_aus/dp/plugin_3dr/ap-commons-1.1.jar $packagepath/iap_aus/dp/plugin_iap/
mv $packagepath/iap_aus/dp/plugin_3dr/uap_gather-1.1.jar $packagepath/iap_aus/dp/plugin_iap/
mv $packagepath/iap_aus/dp/plugin_3dr/uapframecore-1.0.jar $packagepath/iap_aus/dp/plugin_iap/

cd $packagepath/iap_aus/dp/

tar -zcvf iap_aus_dataprocess.tar.gz plugin_3dr plugin_iap conf

mkdir -p ~/package/sssia/安装包/iap_aus/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp iap_aus_dataprocess.tar.gz ~/package/sssia/安装包/iap_aus/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
