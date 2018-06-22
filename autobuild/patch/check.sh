#!/bin/sh
spath=/home/aiuap/autobuild/patch
jhome=/home/aiuap/.jenkins/jobs
cd $spath
echo "����release�汾Ϊ��$1"
echo "ָ���ԱȰ汾Ϊ��$2"
pvp=/home/aiuap/autobuild/patch/pv
svnpath="http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$1"

if [ ! -f $pvp/$1.version ]; then
	echo "��δ�趨�������㣡"
	echo "����10.1.198.53��·��$pvp�����ð汾$1�ķ�������"
	exit 0
fi
vd=`awk 'NR==1{print $0}' $pvp/$1.version`
echo "���²����汾Ϊ��$vd"

if [ "$2" == 'LATEST' ]; then
	vn=`svn info $svnpath|awk -F: '$1=="Last Changed Rev"{print $2}'|sed 's/ //g'`
	echo "��ǰ�汾Ϊ��$vn"
else
	vn=$2
	echo "ָ���汾Ϊ��$vn"
fi



if [ $vd -eq $vn ]; then
	echo "�޴������İ汾"
else
	echo "�д������İ汾:"
	plist=`svn log $svnpath -v -r$vn:$vd|grep products|awk '{print $2}'|awk -F'/' '{print $6}'|awk '{a[$1]++}END{for (i in a) {print "  "i}}'`
	echo $plist

	#exit 1
fi
gu=`sh $spath/g2u.sh "$plist"`

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/2�����ݲ���1���ɲ���3/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/2�����ݲ���1���ɲ���3/config.xml >2config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 2�����ݲ���1���ɲ���3 <2config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/4���ϴ�����������ftp/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/4���ϴ�����������ftp/config.xml >4config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 4���ϴ�����������ftp <4config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/5�����������ʼ�֪ͨ/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/5�����������ʼ�֪ͨ/config.xml >5config.xml
sed -i "`awk '$1=="<name>PROJECTS</name>"{print (NR+2)}' 5config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$gu<\/defaultValue>/g"  5config.xml 
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5�����������ʼ�֪ͨ <5config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/6����¼���η�����svn�汾��/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/6����¼���η�����svn�汾��/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6����¼���η�����svn�汾�� <6config.xml
