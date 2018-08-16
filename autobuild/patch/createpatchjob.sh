#!/bin/sh

if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
  echo "��������"
  exit 1
fi

spath=/home/aiuap/autobuild/patch
cd $spath
echo "����release�汾Ϊ��$1"
echo "ָ���������İ汾Ϊ��$2"
echo "ָ�������汾Ϊ��$3"
pvp=/home/aiuap/autobuild/patch/pv
svnpath="http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$1"
jhome=/home/aiuap/.jenkins/jobs

if [ ! -f $pvp/$1.version ]; then
        echo "��δ�趨�������㣡"
        echo "����10.1.198.53��·��$pvp�����ð汾$1�ķ�������"
        exit 0
fi
if [ "$3" == 'LASTRELEASE' ]; then
	vd=`awk 'NR==1{print $0}' $pvp/$1.version`
	echo "���²����汾Ϊ��$vd"
else
	vd=$3
	echo "ָ�������汾Ϊ��$vn"
fi

if [ "$2" == 'LATEST' ]; then
        vn=`svn info $svnpath|awk -F: '$1=="Last Changed Rev"{print $2}'|sed 's/ //g'`
        echo "��ǰ�汾Ϊ��$vn"
else
        vn=$2
        echo "ָ���汾Ϊ��$vn"
fi


cp config.xml.bak config.xml
if [ $vd -eq $vn ]; then
        echo "�޴������İ汾"
else
        echo "�д������İ汾:"
        projects=`svn log $svnpath -v -r$vn:$[$vd+1]|grep products|awk '{print $2}'|awk -F'/' '{print $6}'|awk '{a[$1]++}END{for (i in a) {print i"full"}for (i in a) {print i"incre"}}'|sed 's/-/_/g'|sed "s/#.*/#/g"`
	fulls=`java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ list-jobs ����`
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
			echo "$i��û�������������"
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
	java -jar jenkins-cli.jar -s http://10.1.198.53:9081/jenkins/ update-job 3����֯��������Ŀ¼ <config.xml

fi
