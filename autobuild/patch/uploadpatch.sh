#!/bin/sh
patchpath=/home/aiuap/patch
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/patch

if [[ -z "$1" ||  -z "$2" ||  -z "$3" ||  -z "$4"  ]]; then

  echo "��������"
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
  echo "������Ŀ¼����"
  exit 1
fi 
done
cd $spath
gu=`sh $spath/g2u.sh $2`
sleep 2
echo "�޸Ĳ���5�Ĳ���"
sed "`awk '$1=="<name>PATCHNAME</name>"{print (NR+2)}' $jhome/5�����������ʼ�֪ͨ/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$gu<\/defaultValue>/g"  $jhome/5�����������ʼ�֪ͨ/config.xml >5config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5�����������ʼ�֪ͨ <5config.xml

echo "�޸Ĳ���7�Ĳ���"
sed "`awk '$1=="<name>PATCHNAME</name>"{print (NR+2)}' $jhome/7���������ϴ�������ƽ̨/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$gu<\/defaultValue>/g"  $jhome/7���������ϴ�������ƽ̨/config.xml >7config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 7���������ϴ�������ƽ̨ <7config.xml

ncftpput -u $3 -p $4 -P 21 -m -R 10.1.252.239 ./ai4a30/aisia1.0/��Ʒ����/ $patchpath/$1
#ncftpput -u $3 -p $4 -P 21 -m -R 10.1.252.239 ./ai4a30/aisia1.0/��ʱ������/ $patchpath/$1
