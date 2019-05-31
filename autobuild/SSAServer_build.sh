#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

ssa_client=$1
SSAServerSvnhome=/home/aiuap/svnproject/program30/program/SSAServer
SSAServerBuildhome=/home/aiuap/svnproject/program30/builddir/SSAServer
SSACSvnhome=/home/aiuap/svnproject/program30/program/ssac
SSACBuildhome=/home/aiuap/svnproject/program30/builddir/ssac

svn up $SSAServerSvnhome
result=$?
if [ $result != '0' ]
then
  echo "更新SSAServer目录错误"
  exit 1
fi
rm -rf $SSAServerBuildhome/SSAServer
if [ $result != '0' ]
then
  echo "删除SSAServer编译目录错误"
  exit 1
fi
svn up $SSACSvnhome
if [ $result != '0' ]
then
  echo "更新SSAC目录错误"
  exit 1
fi
rm -rf $SSACBuildhome
if [ $result != '0' ]
then
  echo "删除SSAC编译目录错误"
  exit 1
fi

cp -rf $SSAServerSvnhome $SSAServerBuildhome/SSAServer
if [ $result != '0' ]
then
  echo "拷贝SSAServer目录错误"
  exit 1
fi

cp -rf $SSACSvnhome $SSACBuildhome
if [ $result != '0' ]
then
  echo "拷贝SSAC目录错误"
  exit 1
fi

#cd $SSACBuildhome
#cp -rf $SSACBuildhome/node_modules $SSACBuildhome/ssac/${ssa_client}/
cd $SSACBuildhome/${ssa_client}
npm install
result=$?
if [ $result != '0' ]
then
  echo "复制node依赖错误！"
  exit 1
fi

cd $SSACBuildhome/${ssa_client}
npm run build
result=$?
if [ $result != '0' ]
then
  echo "前端工程编译错误！"
  exit 1
fi
#cp static/* ../viewServer/src/main/resources/static/ -r
cd dist
mkdir static-new
mv index.html static ./static-new/
mv static-new static

cd $SSAServerBuildhome
cp pom.xml ./SSAServer/
cd SSAServer
mvn package -Dmaven.test.skip=true >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"

cd target
#将前台放进去，重新打包.war
unzip SSAServer.war -d $SSAServerBuildhome/SSAServer/target/SSAServer-new
cp -R $SSACBuildhome/${ssa_client}/dist/static ./SSAServer-new/
cd SSAServer-new
jar -cvfM0 SSAServer.war ./
result=$?
if [ $result != '0' ]
then
  echo "打包失败！"
  exit 1
fi
echo "打包成功！"
