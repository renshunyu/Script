#!/bin/bash
#切换的当前脚本所在的目录
spath=/home/aiuap/autobuild/release
cd $spath
#审计的打包目录
builddir=/home/aiuap/svnproject/program30/builddir
#发布版本的svn地址
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/program/iap
#更新文件开始插入的行数
r=16
#svn的release最新版本号
vn=110118
#当前发布的最新版本号
vo=110037
#cp upmu.sh $builddir/iapupdate/update.sh
#删除上次的增量包
rm -fr $builddir/iapupdate
#删除后重新创建
mkdir $builddir/iapupdate
#按照模板复制一份update脚本
cp upmu.sh $builddir/iapupdate/update.sh
cp readme.txt $builddir/iapupdate/readme.txt
#打印
cat $builddir/iapupdate/update.sh
#遍历发生变更的文件
for i in $(svn diff -r$vn:$vo $svnurl|grep $vn|awk '{print $2}'|sed 's/src\/main\/java/$iapdir\/WEB-INF\/classes/g' |sed 's/.java/.class/g'|sed 's/WebRoot/$iapdir/g')
do
	#获取修改的文件名
	j=$(echo $i|awk -F / '{print $NF}')
	#不带后缀的文件名
	#fn=$(echo $j|awk -F . '{print $1}')
	#文件的后缀
	fe=$(echo $j|awk -F . '{print $NF}')
        #不带后缀的文件名
        fn=$(echo $j|sed "s/\.$fe//g")
	#打印
	echo "cp $j $i"
	#更新文件插入的行数加1
	r=$[$r+1]
	#打印
	echo $str
	echo $r
	#sed -i "$r i cp $j $(echo $i|sed "s/$j//g")" $builddir/iapupdate/update.sh
	#update脚本插入跟新语句
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
#打印
cat $builddir/iapupdate/update.sh

#创建iap目录
mkdir $builddir/iapupdate/iap
#复制iap.war
sudo cp $builddir/iap/target/dist/iap.war $builddir/iapupdate/iap
cd $builddir/iapupdate/iap
#解压
jar -xvf iap.war
cd ..
#遍历修改的文件
for i in $(svn diff -r$vn:$vo $svnurl|grep $vn|awk '{print $2}'|sed 's/src\/main\/java/iap\/WEB-INF\/classes/g' |sed 's/.java/.class/g'|sed 's/WebRoot/iap/g')
do
	#cp $(echo $i|awk -F . '{print $1}')*.$(echo $i|awk -F . '{print $2}') .
	#把修改的文件复制出来
        #文件的后缀
	echo $i
        fe=$(echo $i|awk -F . '{print $NF}')
	echo $fe
        #不带后缀的文件名
        fn=$(echo $i|sed "s/\.$fe//g")
	mkdir -p temp$(echo $i|sed "s/$(echo $i|awk -F / '{print $NF}')//g")
	echo $(echo $i|sed "s/$(echo $i|awk -F / '{print $NF}')//g")	
	cp $(ls $fn*.$fe|grep -P $fn'(\$\d+)?'.$fe) temp$(echo $i|sed "s/$(echo $i|awk -F / '{print $NF}')//g")/
done
#删除iap目录
rm -fr iap
mv tempiap iap
