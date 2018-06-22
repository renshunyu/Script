#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" ]]; then
  echo "参数不足，需要四个参数"
  exit 1
fi
ISBUILD=$1
VER=$2
SVNTAG=$3
SVNBASE=$4


echo $1
if [ false == $1 ]; then
  echo "取消打包"
  exit 0
fi

patchpath=/home/aiuap/svnproject/program30/release/patch/incre
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/iap
thsvnurl=$(echo $svnurl/|sed 's/\//\\\//g')
spath=/home/aiuap/autobuild/patch/patchs/iapincrepatchmu

#删除上次的增量包
rm -fr $patchpath/iapupdate
#删除后重新创建
mkdir $patchpath/iapupdate
#按照模板复制一份update脚本
cp $spath/upmu.sh $patchpath/iapupdate/update.sh
cp $spath/readme.txt $patchpath/iapupdate/readme.txt
#打印
cat $patchpath/iapupdate/update.sh
svn diff --summarize -r$SVNBASE:$SVNTAG $svnurl|grep -v 'src/main/resource'|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"
svn diff --summarize -r$SVNBASE:$SVNTAG $svnurl|grep -v 'src/main/resource'|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"|sed 's/src\/main\/java/$iapdir\/WEB-INF\/classes/g'
#exit 1

#更新文件开始插入的行数
r=16
#遍历发生变更的文件
for i in $(svn diff --summarize -r$SVNBASE:$SVNTAG $svnurl|grep -v 'src/main/resource'|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"|sed 's/src\/main\/java/$iapdir\/WEB-INF\/classes/g' |sed 's/.java/.class/g'|sed 's/WebRoot/$iapdir/g')
do
        #获取修改的文件名
        j=$(echo $i|awk -F / '{print $NF}')
        #文件的后缀
        fe=$(echo $j|awk -F . '{print $NF}')
        #不带后缀的文件名
        fn=$(echo $j|sed "s/\.$fe//g")
        #打印
        echo "cp $j $i"
        #更新文件插入的行数加1
        r=$[$r+1]
        #打印
        #echo $str
        echo $r
        #sed -i "$r i cp $j $(echo $i|sed "s/$j//g")" $builddir/iapupdate/update.sh
        #update脚本插入跟新语句
        sed -i "$r i cp \$(ls $(echo $i|sed "s/$j//g"|sed 's/$iapdir/iap/g')$fn*.$fe|grep -P $fn'(\\\\$\\\d+)?'.$fe) $(echo $i|sed "s/$j//g")" $patchpath/iapupdate/update.sh
        r=$[$r+1]
        echo $r
        echo 'result $?'
        sed -i "$r i result \$?" $patchpath/iapupdate/update.sh
        r=$[$r+1]
        echo $r
        echo ''
        sed -i "$r i \ " $patchpath/iapupdate/update.sh

done
#打印
cat $patchpath/iapupdate/update.sh



#exit 1

cd $patchpath
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi

if [ -d iap ]; then
  rm -fr iap
fi


svn checkout $svnurl -r$3
result=$?
if [ $result != '0' ]
then
  echo "签出目录错误"
  exit 1
fi


cd iap
result=$?
if [ $result != '0' ]
then
  echo "切换目录错误"
  exit 1
fi


ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "编译报错"
  exit 1
fi
echo "编译成功"


#创建iap目录
mkdir $patchpath/iapupdate/iap
#复制iap.war
sudo cp $patchpath/iap/target/dist/iap.war $patchpath/iapupdate/iap
cd $patchpath/iapupdate/iap
#解压
jar -xvf iap.war
cd ..
#遍历修改的文件
echo "svn diff -r$SVNTAG:$SVNBASE $svnurl"
for i in $(svn diff --summarize -r$SVNBASE:$SVNTAG $svnurl|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"|sed 's/src\/main\/java/iap\/WEB-INF\/classes/g' |sed 's/.java/.class/g'|sed 's/WebRoot/iap/g')
do
        #cp $(echo $i|awk -F . '{print $1}')*.$(echo $i|awk -F . '{print $2}') .
        #把修改的文件复制出来
        #文件的后缀
        fe=$(echo $i|awk -F . '{print $NF}')
        #不带后缀的文件名
        fn=$(echo $i|sed "s/\.$fe//g")
        mkdir -p temp$(echo $i|sed "s/$(echo $i|awk -F / '{print $NF}')//g")
        cp $(ls $fn*.$fe|grep -P $fn'(\$\d+)?'.$fe) temp$(echo $i|sed "s/$(echo $i|awk -F / '{print $NF}')//g")/
done
#删除iap目录
rm -fr iap

if [ -d tempiap ];then
        mv tempiap iap
fi


mkdir -p ~/patch/$2/安装包/iap/xxxxx_yyyymmddhhmi/增量/
result=$?
if [ $result != '0' ]
then
  echo "创建目录错误"
  exit 1
fi
cp -r $patchpath/iapupdate ~/patch/$2/安装包/iap/xxxxx_yyyymmddhhmi/增量/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包错误"
  exit 1
fi

