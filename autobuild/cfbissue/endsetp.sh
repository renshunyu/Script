#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/fbissue

if [ -z "$1" ]; then

  echo "参数不足"
  exit 1
fi
echo ${#1}
EDT=$1
echo $EDT
cd $spath
sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/2、对比集中化指定版本program和release的提交记录/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/2、对比集中化指定版本program和release的提交记录/config.xml >2config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 2、对比集中化指定版本program和release的提交记录 <2config.xml
