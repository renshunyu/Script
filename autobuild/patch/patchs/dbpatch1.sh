#!/bin/sh
if [[ -z "$1" || -z "$2" ]]; then
 echo "��������"
 exit 1
fi

dbpath="/home/aiuap/svnproject/program30/builddir/db�ű�"
svnpath="http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/doc/05-�ֲ�/db�ű�"

svn update $dbpath
vernum=`echo $1|awk -F"_" '{print $1}'|sed 's/aisia//g'`

slist=`find $dbpath/$vernum -type d -name xxxxxxxx_yyyymmddhhmi`

for i in $slist
do
echo $i
s=${i/${dbpath}/${svnpath}}
echo $s
svn move $s ${s/xxxxxxxx_yyyymmddhhmi/$2} -m "������������"
done


svn update $dbpath
plist=`find $dbpath/$vernum -name $2`

for i in $plist

do
ia=${i/$dbpath\/$vernum\//}
ib=${ia/\/$2/}
mkdir -p ~/patch/$1/db�ű�/$ib
echo $i
echo ~/patch/$1/db�ű�/$ib
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi



cp -r $i  ~/patch/$1/db�ű�/$ib
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ������"
  exit 1
fi

done
