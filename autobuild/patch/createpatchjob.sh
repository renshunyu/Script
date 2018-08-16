#!/bin/sh

if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
  echo "参数不足"
  exit 1
fi

spath=/home/aiuap/autobuild/patch
cd $spath
echo "输入release版本为：$1"
echo "指定升级到的版本为：$2"
echo "指定基础版本为：$3"
pvp=/home/aiuap/autobuild/patch/pv
svnpath="http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$1"
jhome=/home/aiuap/.jenkins/jobs

if [ ! -f $pvp/$1.version ]; then
        echo "还未设定发布基点！"
        echo "请在10.1.198.53的路径$pvp下设置版本$1的发布基点"
        exit 0
fi
if [ "$3" == 'LASTRELEASE' ]; then
	vd=`awk 'NR==1{print $0}' $pvp/$1.version`
	echo "最新补丁版本为：$vd"
else
	vd=$3
	echo "指定基础版本为：$vn"
fi

if [ "$2" == 'LATEST' ]; then
        vn=`svn info $svnpath|awk -F: '$1=="Last Changed Rev"{print $2}'|sed 's/ //g'`
        echo "当前版本为：$vn"
else
        vn=$2
        echo "指定版本为：$vn"
fi


cp config.xml.bak config.xml
if [ $vd -eq $vn ]; then
        echo "无待发布的版本"
else
        echo "有待发布的版本:"
        projects=`svn log $svnpath -v -r$vn:$[$vd+1]|grep products|awk '{print $2}'|awk -F'/' '{print $6}'|awk '{a[$1]++}END{for (i in a) {print i"full"}for (i in a) {print i"incre"}}'|sed 's/-/_/g'|sed "s/#.*/#/g"`
	fulls=`java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ list-jobs 补丁`
	echo $projects |sed 's/\( \)\+/\n/g'
	echo "******************"
	echo $fulls
	echo "******************"	
	for i in $projects
	do
		echo $i
		if [ `echo $fulls|awk '{for (i=1;i<=NF;i++){print $i}}'|grep '^'$i'$'|wc -l` != 0 ]; then
			content=`sed "s\<projects>.*</projects>\<projects>$i</projects>\g" post.xml|sed "s/<properties>.*<\/properties>/<properties>ISBUILD=\$\{$i\}\\\\\nVER=\$\{VER\}\\\\\nSVNTAG=\$\{SVNTAG\}\\\\\nSVNBASE=\$\{SVNBASE\}<\/properties>/g"`
			echo "$content"
			sed -i "28i $content" config.xml
			echo "**********************************"
		else
			wnr=$wnr$i','
			echo "$i还没有纳入持续集成"
		fi
	done
        for i in $projects
        do
                echo $i
                if [ `echo $fulls|awk '{for (i=1;i<=NF;i++){print $i}}'|grep '^'$i'$'|wc -l` != 0 ]; then
                        content=`sed "s/<name>.*<\/name>/<name>$i<\/name>/g" pre.xml`
                        echo "$content"
                        sed -i "9i $content" config.xml
                        echo "**********************************"
                fi
        done
	content=`sed "s/<defaultValue>.*<\/defaultValue>/<defaultValue>$1<\/defaultValue>/g" ver.xml`
	sed -i "9i $content" config.xml
        content=`sed "s/<defaultValue>.*<\/defaultValue>/<defaultValue>$vd<\/defaultValue>/g" base.xml`
        sed -i "9i $content" config.xml
        content=`sed "s/<defaultValue>.*<\/defaultValue>/<defaultValue>$vn<\/defaultValue>/g" tag.xml`
        sed -i "9i $content" config.xml
        content=`sed "s/<defaultValue>.*<\/defaultValue>/<defaultValue>$wnr<\/defaultValue>/g" textp.xml`
        sed -i "9i $content" config.xml
	java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 3、组织补丁发布目录 <config.xml

fi
