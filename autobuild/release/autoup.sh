#!/bin/bash
#�л��ĵ�ǰ�ű����ڵ�Ŀ¼
spath=/home/aiuap/autobuild/release
cd $spath
#��ƵĴ��Ŀ¼
builddir=/home/aiuap/svnproject/release/builddir
#releaseԴ�뱾��·��
rpath=/home/aiuap/svnproject/release/iap
#�����汾��svn��ַ
svnurl=$(svn info $rpath|awk 'NR==2{print $2}')
thsvnurl=$(echo $svnurl/|sed 's/\//\\\//g')
#�����ļ���ʼ���������
r=16
#svn��release���°汾��
vn=$(svn log -q -l 1 $svnurl|awk 'NR==2{print $1}'|awk -F r '{print $2}')
#��ǰ���������°汾��
vo=$(awk 'NR == 1' /home/aiuap/autobuild/release/iap.version)
#cp upmu.sh $builddir/iapupdate/update.sh
#ɾ���ϴε�������
rm -fr $builddir/iapupdate
#ɾ�������´���
mkdir $builddir/iapupdate
#����ģ�帴��һ��update�ű�
cp upmu.sh $builddir/iapupdate/update.sh
cp readme.txt $builddir/iapupdate/readme.txt
#��ӡ
cat $builddir/iapupdate/update.sh
#��������������ļ�
for i in $(svn diff --summarize -r$vo:$vn $svnurl|grep -v 'src/main/resource'|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"|sed 's/src\/main\/java/$iapdir\/WEB-INF\/classes/g' |sed 's/.java/.class/g'|sed 's/WebRoot/$iapdir/g')
do
	#��ȡ�޸ĵ��ļ���
	j=$(echo $i|awk -F / '{print $NF}')
	#�ļ��ĺ�׺
	fe=$(echo $j|awk -F . '{print $NF}')
	#������׺���ļ���
	fn=$(echo $j|sed "s/\.$fe//g")
	#��ӡ
	echo "cp $j $i"
	#�����ļ������������1
	r=$[$r+1]
	#��ӡ
	#echo $str
	echo $r
	#sed -i "$r i cp $j $(echo $i|sed "s/$j//g")" $builddir/iapupdate/update.sh
	#update�ű�����������
	sed -i "$r i cp \$(ls $(echo $i|sed "s/$j//g"|sed 's/$iapdir/iap/g')$fn*.$fe|grep -P $fn'(\\\\$\\\d+)?'.$fe) $(echo $i|sed "s/$j//g")" $builddir/iapupdate/update.sh
	r=$[$r+1]
	echo $r
	echo 'result $?'
	sed -i "$r i result \$?" $builddir/iapupdate/update.sh
	r=$[$r+1]
	echo $r
	echo ''
	sed -i "$r i \ " $builddir/iapupdate/update.sh

done
#��ӡ
cat $builddir/iapupdate/update.sh

#����iapĿ¼
mkdir $builddir/iapupdate/iap
#����iap.war
sudo cp $builddir/iap/target/dist/iap.war $builddir/iapupdate/iap
cd $builddir/iapupdate/iap
#��ѹ
jar -xvf iap.war
cd ..
#�����޸ĵ��ļ�
echo "svn diff -r$vn:$vo $svnurl"
for i in $(svn diff --summarize -r$vo:$vn $svnurl|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"|sed 's/src\/main\/java/iap\/WEB-INF\/classes/g' |sed 's/.java/.class/g'|sed 's/WebRoot/iap/g')
do
	#cp $(echo $i|awk -F . '{print $1}')*.$(echo $i|awk -F . '{print $2}') .
	#���޸ĵ��ļ����Ƴ���
        #�ļ��ĺ�׺
        fe=$(echo $i|awk -F . '{print $NF}')
        #������׺���ļ���
        fn=$(echo $i|sed "s/\.$fe//g")
	mkdir -p temp$(echo $i|sed "s/$(echo $i|awk -F / '{print $NF}')//g")
	cp $(ls $fn*.$fe|grep -P $fn'(\$\d+)?'.$fe) temp$(echo $i|sed "s/$(echo $i|awk -F / '{print $NF}')//g")/
done
#ɾ��iapĿ¼
rm -fr iap

if [ -d tempiap ];then
	mv tempiap iap
fi
