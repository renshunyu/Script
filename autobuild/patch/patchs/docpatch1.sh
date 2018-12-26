#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


if [[ -z "$1" || -z "$2" ]]; then
 echo "参数不足"
 exit 1
fi

docpath="/home/aiuap/svnproject/program30/builddir/发布相关的文档"
wordoperpath=/home/aiuap/autobuild/patch/patchs
svn update $docpath


mkdir -p ~/patch/$1/doc
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
vernum=`echo $1|awk -F"_" '{print $1}'|sed 's/aisia//g'`
java -jar ${wordoperpath}/wordoper-jar-with-dependencies.jar $docpath/$vernum/移动4A项目审计补丁发布日志${vernum}.docx $docpath/$vernum/移动4A项目审计补丁发布日志${vernum}.docx xxxxxxxx `echo $2|awk -F_ '{print $1}'`
java -jar ${wordoperpath}/wordoper-jar-with-dependencies.jar $docpath/$vernum/移动4A项目审计补丁发布日志${vernum}.docx $docpath/$vernum/移动4A项目审计补丁发布日志${vernum}.docx yyyymmddhhmi `echo $2|awk -F_ '{print $NF}'`
svn commit $docpath/$vernum/移动4A项目审计补丁发布日志${vernum}.docx  -m "补丁发布！！"
cp $docpath/$vernum/移动4A项目审计补丁发布日志*.docx  ~/patch/$1/doc/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi
