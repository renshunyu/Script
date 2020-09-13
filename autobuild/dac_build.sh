#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
svnhome=/home/aiuap/svnproject/program30/program/kettle
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "∏¸–¬svnƒø¬º¥ÌŒÛ"
  exit 1
fi
rm -rf $buildhome/kettle
if [ $result != '0' ]
then
  echo "…æ≥˝±‡“Îƒø¬º¥ÌŒÛ"
  exit 1
fi
cp -rf $svnhome $buildhome/kettle
result=$?
if [ $result != '0' ]
then
  echo "øΩ±¥ƒø¬º¥ÌŒÛ"
  exit 1
fi
cd $buildhome/kettle

if [ -d ./kettle_client/workflow ]
then
  cd ./kettle_client/workflow
  npm cache clean --force
  #rm '~/.node-gyp' -fr
  npm config set registry https://registry.npm.taobao.org
  npm install
  result=$?
  if [ $result != '0' ]
  then
    echo "œ¬‘ÿ“¿¿µ¥ÌŒÛ"
    exit 1
  fi
  npm run build
  result=$?
  if [ $result != '0' ]
  then
    echo "«∞Ã®¥Ú∞¸¥ÌŒÛ"
    exit 1
  fi
  cd ../../

fi 


cd ./kettle-web-assemble/kettle-core
mvn clean install -Dmaven.test.skip=true >./build.log


result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡“Î≥…π¶"
cd ../../

cd ./kettle-web-assemble/kettle-engine
mvn clean install -Dmaven.test.skip=true >./build.log


result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡“Î≥…π¶"
cd ../../


cd ./kettle-web-assemble/kettle-server
mvn clean install -Dmaven.test.skip=true  -Djava.io.tmpdir=/home/aiuap/tmp>./build.log


#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡“Î≥…π¶"
cd ../../
