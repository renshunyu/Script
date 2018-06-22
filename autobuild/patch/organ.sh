#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/patch

if [ -z "$1" ]; then

  echo "参数不足"
  exit 1
fi
echo ${#1}
cd $spath
sed "`awk '$1=="<name>SVNTAG</name>"{print (NR+2)}' $jhome/6、记录本次发布的svn版本号/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/6、记录本次发布的svn版本号/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6、记录本次发布的svn版本号 <6config.xml
