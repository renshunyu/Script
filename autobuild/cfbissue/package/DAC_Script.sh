#!bin/sh
#svnhome=/home/aiuap/svnproject/program30/program/DAC_Script
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ -z "$1" ]]; then
  echo "参数不足"
  exit 1
fi

buildhome=/home/aiuap/svnproject/program30rm/fbissue
svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/DAC_Script

cd $buildhome
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "更新svn目录错误"
  exit 1
fi


rm -rf $buildhome/DAC_Script
if [ $result != '0' ]
then
  echo "删除编译目录错误"
  exit 1
fi


svn checkout $svnhome
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi
#cp -rf $svnhome $buildhome/DAC_Script
#result=$?
##then
 # echo "拷贝目录错误"
 # exit 1
#fi
rm -fr `find DAC_Script -name '.svn*'|grep -v '^.$'|grep -v '^..$'`

tar -zcvf DAC_Script.tar.gz DAC_Script

mkdir -p ~/package/sssia/安装包/DAC_Script
cp DAC_Script.tar.gz ~/package/sssia/安装包/DAC_Script/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0




