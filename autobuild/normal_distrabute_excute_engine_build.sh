#!bin/sh
export JAVA_HOME=/usr/java/jdk1.7.0_80
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$PATH
svnhome=/home/aiuap/svnproject/program30/program/normal_distrabute_excute_engine
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "∏¸–¬svnƒø¬º¥ÌŒÛ"
  exit 1
fi
rm -rf  $buildhome/normal_distrabute_excute_engine
if [ $result != '0' ]
then
  echo "…æ≥˝±‡“Îƒø¬º¥ÌŒÛ"
  exit 1
fi
cp -rf $svnhome $buildhome/normal_distrabute_excute_engine
result=$?
if [ $result != '0' ]
then
  echo "øΩ±¥ƒø¬º¥ÌŒÛ"
  exit 1
fi
cd $buildhome/normal_distrabute_excute_engine

mvn clean package -Dmaven.test.skip=true >./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡º≠≥…π¶"
