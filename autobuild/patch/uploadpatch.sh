#!/bin/sh
patchpath=/home/aiuap/patch
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/patch

if [[ -z "$1" ||  -z "$2" ||  -z "$3" ||  -z "$4"  ]]; then

  echo "参数不足"
  exit 1
fi
echo ${#1}
echo ${#2}

ds=`find $patchpath/$1 -name xxxxx_yyyymmddhhmi`
for i in $ds
do
mv $i ${i/"xxxxx_yyyymmddhhmi"/"$2"}
result=$?
if [ $result != '0' ]
then
  echo "重命名目录错误"
  exit 1
fi 
done
cd $spath
gu=`sh $spath/g2u.sh $2`
sleep 2
echo "修改步骤5的参数"
sed "`awk '$1=="<name>PATCHNAME</name>"{print (NR+2)}' $jhome/5、补丁发布邮件通知/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$gu<\/defaultValue>/g"  $jhome/5、补丁发布邮件通知/config.xml >5config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5、补丁发布邮件通知 <5config.xml

echo "修改步骤7的参数"
sed "`awk '$1=="<name>PATCHNAME</name>"{print (NR+2)}' $jhome/7、将补丁上传至发布平台/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$gu<\/defaultValue>/g"  $jhome/7、将补丁上传至发布平台/config.xml >7config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 7、将补丁上传至发布平台 <7config.xml

ncftpput -u $3 -p $4 -P 21 -m -R 10.1.252.239 ./ai4a30/aisia1.0/产品发布/ $patchpath/$1
#ncftpput -u $3 -p $4 -P 21 -m -R 10.1.252.239 ./ai4a30/aisia1.0/临时开发版/ $patchpath/$1
