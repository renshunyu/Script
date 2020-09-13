#!bin/sh
#export JAVA_HOME=/usr/java/jdk1.6.0_31
export JAVA_HOME=/usr/java/jdk1.8.0_121
export GRADLE_HOME=/usr/java/gradle-4.10
export PATH=$GRADLE_HOME/bin:$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

baseJarReleaseVersion=''

if [[ -z "$1" ]]; then
  echo "参数未填写，需要输入需要打包的git分支"
  exit 1
fi
GITBRANCH=$1
echo $1

githome=/home/aiuap/gitprojeck/AISIA/a4-audit-workflow
buildhome=/home/aiuap/gitprojeck/AISIA/builddir

cd $githome
git checkout $1
result=$?
if [ $result != '0' ]
then
  echo "切换git分支错误"
  exit 1
fi
echo "切换git分支成功"

git pull 
result=$?
if [ $result != '0' ]
then
  echo "更新git目录错误"
  exit 1
fi
echo "更新git目录成功"
rm -rf $buildhome/a4-audit-workflow
if [ $result != '0' ]
then
  echo "删除编译目录错误"
  exit 1
fi
cp -rf $githome $buildhome/a4-audit-workflow
result=$?
if [ $result != '0' ]
then
  echo "拷贝目录错误"
  exit 1
fi
cd $buildhome/a4-audit-workflow
gradle clean build_jar -x test --refresh-dependencies -DdbType=mysql -DbaseJarVersionUtil=$baseJarReleaseVersion -DbaseJarVersionConfig=$baseJarReleaseVersion -DbaseJarVersionMybatis=$baseJarReleaseVersion -DbaseJarVersionSwagger=$baseJarReleaseVersion -DbaseJarVersionDruid=$baseJarReleaseVersion -DbaseJarVersionRedis=$baseJarReleaseVersion -DbaseJarVersionTestBase=$baseJarReleaseVersion -b build-jar.gradle >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then 
 echo "jar编译报错"
 exit 1
fi
echo "jar编译成功"

