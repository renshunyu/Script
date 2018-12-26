#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ ! -n "$1" || ! -n "$2" || ! -n "$3" ]]; then
        echo "参数1为本次发布的版本号"
        exit 1
fi
#cp ~/package/sssia ~/$1 -r
echo $4
#exit 0
relasepath=/home/aiuap/release-1.0
rm -r ~/productReleasePlatform
mkdir -p ~/productReleasePlatform/install
mkdir -p ~/productReleasePlatform/doc
mkdir -p ~/productReleasePlatform/db

cd ~/package/sssia/安装包/
for i in `ls`
do 
  #zip -r ~/productReleasePlatform/install/$i.zip $i
  tar -cvf  ~/productReleasePlatform/install/$i.tar $i
done

cd ~/package/sssia/doc/
for i in `ls`
do
  cp -r $i ~/productReleasePlatform/doc/
done

cd ~/package/sssia/db脚本/
for i in `ls`
do
  #zip -r ~/productReleasePlatform/db/$i.zip $i
  tar -cvf  ~/productReleasePlatform/db/$i.tar $i
done

cd ${relasepath}
args=""
args=${args}' 'versionNum=$1
args=${args}' 'login.name=$2
args=${args}' 'login.passwd=$3
echo ${args}
java -classpath ".:./lib/*"  com.asiainfo.release.Issue ${args}
