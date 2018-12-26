#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ ! -n "$1" || ! -n "$2" || ! -n "$3" || ! -n "$4" || ! -n "$5" || ! -n "$6" ]]; then
        echo "参数1为本次发布的基础版本号"
        exit 1
fi
#cp ~/package/sssia ~/$1 -r
relasepath=/home/aiuap/release-1.0
rm -r ~/productReleasePlatformpatch
mkdir -p ~/productReleasePlatformpatch
if [ ! -d /home/aiuap/patch/$1 ]
then
echo "目录不存在"
exit 1
fi

cd /home/aiuap/patch/$1/
#zip -r ~/productReleasePlatformpatch/$2.zip *
tar -cvf  ~/productReleasePlatformpatch/$2.tar *


cd ${relasepath}

args=""
args=${args}' 'versionNum=$1
args=${args}' 'login.name=$3
args=${args}' 'login.passwd=$4
args=${args}' 'fixDescription=\"$5\"
args=${args}' 'fixRemark=\"$6\"
echo ${args}

java -classpath ".:./lib/*"  com.asiainfo.release.Patch ${args}
