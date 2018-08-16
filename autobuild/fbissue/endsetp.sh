#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/fbissue

if [ -z "$1" ]; then

  echo "参数不足"
  exit 1
fi
echo ${#1}
VER=$1
echo $VER
cd $spath
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/2、【封版】对比指定版本program和release的提交记录/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/2、【封版】对比指定版本program和release的提交记录/config.xml >2config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 2、【封版】对比指定版本program和release的提交记录 <2config.xml
