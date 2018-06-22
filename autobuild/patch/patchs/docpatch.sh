#!/bin/sh
if [ -z "$1" ]; then
 echo "��������"
 exit 1
fi

docpath="/home/aiuap/svnproject/program30/builddir/������ص��ĵ�"

svn update $docpath


mkdir -p ~/patch/$1/doc
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
vernum=`echo $1|awk -F"_" '{print $1}'|sed 's/aisia//g'`
cp $docpath/$vernum/�ƶ�4A��Ŀ��Ʋ���������־*.docx  ~/patch/$1/doc/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ������"
  exit 1
fi
