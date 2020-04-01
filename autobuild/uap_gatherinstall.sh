#!/bin/sh
#export JAVA_HOME=/usr/java/jdk1.7.0_80
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.3.9
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

svnhome=/home/aiuap/svnproject/program30/program/uap_gather
buildhome=/home/aiuap/svnproject/program30/builddir
cd $buildhome/uap_gather

mvn install:install-file -Dfile=./target/dist/uap_gather-1.1.jar -DgroupId=com.asiainfo -DartifactId=uap_gather -Dversion=1.1 -Dpackaging=jar >./build.log

result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "±‡“Î±®¥Ì"
  exit 1
fi
echo "±‡“Î≥…π¶"
exit 0
cd $buildhome/uap_gather/target/dist/
echo 'open 10.1.198.60
user aus aus
cd /home/aus/dataprocess/tcp-xml_dataprocess/dataprocess/tmp
bin
put *.jar
' |ftp -n
sleep 3
