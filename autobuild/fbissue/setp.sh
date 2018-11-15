#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/fbissue

if [ -z "$1" ]; then

  echo "参数不足"
  exit 1
fi
echo ${#1}
VER=aisia$1_`date +%Y%m%d`
echo $VER
cd $spath
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/1、审计产品封版/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/1、审计产品封版/config.xml >1config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 1、审计产品封版 <1config.xml


sed "`awk '$1=="<name>MVER</name>"{print (NR+2)}' $jhome/3、【封版】组织版本发布目录和内容/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/3、【封版】组织版本发布目录和内容/config.xml >3config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 3、【封版】组织版本发布目录和内容 <3config.xml
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/4、【封版】上传版本发布目录到ftp/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/4、【封版】上传版本发布目录到ftp/config.xml >4config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 4、【封版】上传版本发布目录到ftp <4config.xml
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/5、【封版】版本发布邮件通知/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/5、【封版】版本发布邮件通知/config.xml >5config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5、【封版】版本发布邮件通知 <5config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/6、【封版】创建本次版本发布的release分支/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/6、【封版】创建本次版本发布的release分支/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6、【封版】创建本次版本发布的release分支 <6config.xml

sed "`awk '$1=="<name>VERNUM</name>"{print (NR+2)}' $jhome/6、【封版】创建本次版本发布的release分支/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/6、【封版】创建本次版本发布的release分支/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6、【封版】创建本次版本发布的release分支 <6config.xml
