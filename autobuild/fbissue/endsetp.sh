#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/fbissue

if [ -z "$1" ]; then

  echo "��������"
  exit 1
fi
echo ${#1}
VER=$1
echo $VER
cd $spath
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/2������桿�Ա�ָ���汾program��release���ύ��¼/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/2������桿�Ա�ָ���汾program��release���ύ��¼/config.xml >2config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 2������桿�Ա�ָ���汾program��release���ύ��¼ <2config.xml