#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/cfbissue

if [ -z "$1" ]; then

  echo "参数不足"
  exit 1
fi
echo ${#1}
EDT=aisiac$1_`date +%Y%m%d`
echo $EDT
cd $spath
sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/1、集中化智能审计产品封板/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/1、集中化智能审计产品封板/config.xml >1config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 1、集中化智能审计产品封板 <1config.xml

sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/2、对比集中化指定版本program和release的提交记录/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/2、对比集中化指定版本program和release的提交记录/config.xml >2config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 2、对比集中化指定版本program和release的提交记录 <2config.xml


sed "`awk '$1=="<name>MEDT</name>"{print (NR+2)}' $jhome/3、组织集中化版本发布目录和内容/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/3、组织集中化版本发布目录和内容/config.xml >3config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 3、组织集中化版本发布目录和内容 <3config.xml
sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/4、上传集中化审计版本发布目录到ftp/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/4、上传集中化审计版本发布目录到ftp/config.xml >4config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 4、上传集中化审计版本发布目录到ftp <4config.xml
sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/5、集中化版本发布邮件通知/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/5、集中化版本发布邮件通知/config.xml >5config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5、集中化版本发布邮件通知 <5config.xml

sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/6、创建本次集中化版本发布的release分支/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/6、创建本次集中化版本发布的release分支/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6、创建本次集中化版本发布的release分支 <6config.xml

sed "`awk '$1=="<name>EDTNUM</name>"{print (NR+2)}' $jhome/6、创建本次集中化版本发布的release分支/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/6、创建本次集中化版本发布的release分支/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6、创建本次集中化版本发布的release分支 <6config.xml

sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/7、将集中化版本上传至发布平台/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/7、将集中化版本上传至发布平台/config.xml >7config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 7、将集中化版本上传至发布平台 <7config.xml
