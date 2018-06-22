#!/bin/sh
spath=/home/aiuap/autobuild/patch
jhome=/home/aiuap/.jenkins/jobs
cd $spath
echo "输入release版本为：$1"
echo "指定对比版本为：$2"
pvp=/home/aiuap/autobuild/patch/pv
svnpath="http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$1"

if [ ! -f $pvp/$1.version ]; then
	echo "还未设定发布基点！"
	echo "请在10.1.198.53的路径$pvp下设置版本$1的发布基点"
	exit 0
fi
vd=`awk 'NR==1{print $0}' $pvp/$1.version`
echo "最新补丁版本为：$vd"

if [ "$2" == 'LATEST' ]; then
	vn=`svn info $svnpath|awk -F: '$1=="Last Changed Rev"{print $2}'|sed 's/ //g'`
	echo "当前版本为：$vn"
else
	vn=$2
	echo "指定版本为：$vn"
fi



if [ $vd -eq $vn ]; then
	echo "无待发布的版本"
else
	echo "有待发布的版本:"
	plist=`svn log $svnpath -v -r$vn:$vd|grep products|awk '{print $2}'|awk -F'/' '{print $6}'|awk '{a[$1]++}END{for (i in a) {print "  "i}}'`
	echo $plist

	#exit 1
fi
gu=`sh $spath/g2u.sh "$plist"`

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/2、根据步骤1生成步骤3/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/2、根据步骤1生成步骤3/config.xml >2config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 2、根据步骤1生成步骤3 <2config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/4、上传发布内容至ftp/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/4、上传发布内容至ftp/config.xml >4config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 4、上传发布内容至ftp <4config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/5、补丁发布邮件通知/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/5、补丁发布邮件通知/config.xml >5config.xml
sed -i "`awk '$1=="<name>PROJECTS</name>"{print (NR+2)}' 5config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$gu<\/defaultValue>/g"  5config.xml 
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 5、补丁发布邮件通知 <5config.xml

sed "`awk '$1=="<name>VER</name>"{print (NR+2)}' $jhome/6、记录本次发布的svn版本号/config.xml`s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g"  $jhome/6、记录本次发布的svn版本号/config.xml >6config.xml
java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 6、记录本次发布的svn版本号 <6config.xml
