#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

echo $1
if [ false == $1 ]; then
  echo "取消打包"
  exit 0
fi

patchpath=/home/aiuap/svnproject/program30/release/patch
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/kettle

cd $patchpath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d kettle ]; then
  rm -fr kettle
fi


svn checkout $svnurl -r$3
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd kettle
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d ./kettle_client/workflow ]
then
  cd ./kettle_client/workflow
  npm install
  result=$?
  if [ $result != '0' ]
  then
    echo "下载依赖错误"
    exit 1
  fi
  npm run build
  result=$?
  if [ $result != '0' ]
  then
    echo "前台打包错误"
    exit 1
  fi
  cd ../../

fi 


cd ./kettle-web-assemble/kettle-core
mvn clean install -Dmaven.test.skip=true >./build.log


result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"
cd ../../

cd ./kettle-web-assemble/kettle-engine
mvn clean install -Dmaven.test.skip=true >./build.log


result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"
cd ../../


cd ./kettle-web-assemble/kettle-server
mvn clean install -Dmaven.test.skip=true  -Djava.io.tmpdir=/home/aiuap/tmp>./build.log


#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"
cd ../../




mkdir -p ~/patch/$2/安装包/dac/xxxxx_yyyymmddhhmi/全量/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi

cp $patchpath/kettle/kettle_client/workflow/dist  $patchpath/kettle/kettle-web-assemble/kettle-server/target/ROOT -r
cd $patchpath/kettle/kettle-web-assemble/kettle-server/target/
tar -zcvf dac.tar.gz kettle-server.war ROOT
cp dac.tar.gz ~/patch/$2/安装包/dac/xxxxx_yyyymmddhhmi/全量/

result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
