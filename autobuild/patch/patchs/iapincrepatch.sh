#!/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" ]]; then
  echo "�������㣬��Ҫ�ĸ�����"
  exit 1
fi
ISBUILD=$1
VER=$2
SVNTAG=$3
SVNBASE=$4


echo $1
if [ false == $1 ]; then
  echo "ȡ�����"
  exit 0
fi

patchpath=/home/aiuap/svnproject/program30/release/patch/incre
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/iap
thsvnurl=$(echo $svnurl/|sed 's/\//\\\//g')
spath=/home/aiuap/autobuild/patch/patchs/iapincrepatchmu

#ɾ���ϴε�������
rm -fr $patchpath/iapupdate
#ɾ�������´���
mkdir $patchpath/iapupdate
#����ģ�帴��һ��update�ű�
cp $spath/upmu.sh $patchpath/iapupdate/update.sh
cp $spath/readme.txt $patchpath/iapupdate/readme.txt
#��ӡ
cat $patchpath/iapupdate/update.sh
svn diff --summarize -r$SVNBASE:$SVNTAG $svnurl|grep -v 'src/main/resource'|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"
svn diff --summarize -r$SVNBASE:$SVNTAG $svnurl|grep -v 'src/main/resource'|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"|sed 's/src\/main\/java/$iapdir\/WEB-INF\/classes/g'
#exit 1

#�����ļ���ʼ���������
r=16
#��������������ļ�
for i in $(svn diff --summarize -r$SVNBASE:$SVNTAG $svnurl|grep -v 'src/main/resource'|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"|sed 's/src\/main\/java/$iapdir\/WEB-INF\/classes/g' |sed 's/.java/.class/g'|sed 's/WebRoot/$iapdir/g')
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
#��ӡ
cat $patchpath/iapupdate/update.sh



#exit 1

cd $patchpath
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi

if [ -d iap ]; then
  rm -fr iap
fi


svn checkout $svnurl -r$3
result=$?
if [ $result != '0' ]
then
  echo "ǩ��Ŀ¼����"
  exit 1
fi


cd iap
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi


ant >./build.log
result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"


#����iapĿ¼
mkdir $patchpath/iapupdate/iap
#����iap.war
sudo cp $patchpath/iap/target/dist/iap.war $patchpath/iapupdate/iap
cd $patchpath/iapupdate/iap
#��ѹ
jar -xvf iap.war
cd ..
#�����޸ĵ��ļ�
echo "svn diff -r$SVNTAG:$SVNBASE $svnurl"
for i in $(svn diff --summarize -r$SVNBASE:$SVNTAG $svnurl|awk '$1!="D"{print $2}'|sed "s/$thsvnurl//g"|sed 's/src\/main\/java/iap\/WEB-INF\/classes/g' |sed 's/.java/.class/g'|sed 's/WebRoot/iap/g')
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


mkdir -p ~/patch/$2/��װ��/iap/xxxxx_yyyymmddhhmi/����/
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
cp -r $patchpath/iapupdate ~/patch/$2/��װ��/iap/xxxxx_yyyymmddhhmi/����/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ������"
  exit 1
fi

