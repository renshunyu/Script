#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/fbissue

if [ -z "$1" ]; then

  echo "��������"
  exit 1
fi
echo ${#1}
VER=aisia$1_`date +%Y%m%d`
echo $VER
cd $spath
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/1����Ʋ�Ʒ���/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/1����Ʋ�Ʒ���/config.xml >1config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 1����Ʋ�Ʒ��� <1config.xml


sed "`awk '$1=="<name>MVER</name>"{print (NR+2)}' $jhome/3������桿��֯�汾����Ŀ¼������/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/3������桿��֯�汾����Ŀ¼������/config.xml >3config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 3������桿��֯�汾����Ŀ¼������ <3config.xml
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/4������桿�ϴ��汾����Ŀ¼��ftp/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/4������桿�ϴ��汾����Ŀ¼��ftp/config.xml >4config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 4������桿�ϴ��汾����Ŀ¼��ftp <4config.xml
sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/5������桿�汾�����ʼ�֪ͨ/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/5������桿�汾�����ʼ�֪ͨ/config.xml >5config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5������桿�汾�����ʼ�֪ͨ <5config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/6������桿�������ΰ汾������release��֧/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$VER<\/defaultValue>/g"  $jhome/6������桿�������ΰ汾������release��֧/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6������桿�������ΰ汾������release��֧ <6config.xml

sed "`awk '$1=="<name>VERNUM</name>"{print (NR+2)}' $jhome/6������桿�������ΰ汾������release��֧/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/6������桿�������ΰ汾������release��֧/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6������桿�������ΰ汾������release��֧ <6config.xml
