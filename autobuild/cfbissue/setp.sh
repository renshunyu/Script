#!/bin/sh
jhome=/home/aiuap/.jenkins/jobs
spath=/home/aiuap/autobuild/cfbissue

if [ -z "$1" ]; then

  echo "��������"
  exit 1
fi
echo ${#1}
EDT=aisiac$1_`date +%Y%m%d`
echo $EDT
cd $spath
sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/1�����л�������Ʋ�Ʒ���/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/1�����л�������Ʋ�Ʒ���/config.xml >1config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 1�����л�������Ʋ�Ʒ��� <1config.xml

sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/2���Աȼ��л�ָ���汾program��release���ύ��¼/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/2���Աȼ��л�ָ���汾program��release���ύ��¼/config.xml >2config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 2���Աȼ��л�ָ���汾program��release���ύ��¼ <2config.xml


sed "`awk '$1=="<name>MEDT</name>"{print (NR+2)}' $jhome/3����֯���л��汾����Ŀ¼������/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/3����֯���л��汾����Ŀ¼������/config.xml >3config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 3����֯���л��汾����Ŀ¼������ <3config.xml
sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/4���ϴ����л���ư汾����Ŀ¼��ftp/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/4���ϴ����л���ư汾����Ŀ¼��ftp/config.xml >4config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 4���ϴ����л���ư汾����Ŀ¼��ftp <4config.xml
sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/5�����л��汾�����ʼ�֪ͨ/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/5�����л��汾�����ʼ�֪ͨ/config.xml >5config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5�����л��汾�����ʼ�֪ͨ <5config.xml

sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/6���������μ��л��汾������release��֧/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/6���������μ��л��汾������release��֧/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6���������μ��л��汾������release��֧ <6config.xml

sed "`awk '$1=="<name>EDTNUM</name>"{print (NR+2)}' $jhome/6���������μ��л��汾������release��֧/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/6���������μ��л��汾������release��֧/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6���������μ��л��汾������release��֧ <6config.xml

sed "`awk '$1=="<name>EDT</name>"{print (NR+2)}' $jhome/7�������л��汾�ϴ�������ƽ̨/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$EDT<\/defaultValue>/g"  $jhome/7�������л��汾�ϴ�������ƽ̨/config.xml >7config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 7�������л��汾�ϴ�������ƽ̨ <7config.xml
