#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/issue

if [ -z "$1" ]; then

  echo "参数不足"
  exit 1
fi
echo ${#1}
VER=aisia$1_`date +%Y%m%d`
echo $VER
cd $spath
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/1、对比指定版本program和release的提交记录/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/1、对比指定版本program和release的提交记录/config.xml >1config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 1、对比指定版本program和release的提交记录 <1config.xml

sed "`awk '$1=="<name>MVER</name>"{print (NR+2)}' $jhome/2、组织版本发布目录和内容/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/2、组织版本发布目录和内容/config.xml >2config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 2、组织版本发布目录和内容 <2config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/3、上传发布目录到ftp/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/3、上传发布目录到ftp/config.xml >3config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 3、上传发布目录到ftp <3config.xml
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/4、版本发布邮件通知/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/4、版本发布邮件通知/config.xml >4config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 4、版本发布邮件通知 <4config.xml
sed "`awk '$1=="<name>ISSUEVERSION</name>"{print (NR+2)}' $jhome/5、创建本次版本发布的release分支/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/5、创建本次版本发布的release分支/config.xml >5config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5、创建本次版本发布的release分支 <5config.xml
