#!bin/sh
#svnhome=/home/aiuap/svnproject/program30/program/ETL_Script
buildhome=/home/aiuap/svnproject/program30rm/fbissue
svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/ETL_Script
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
rm -rf $buildhome/ETL_Script
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cd $buildhome/
svn checkout $svnhome


rm -fr `find ETL_Script -name '.svn*'|grep -v '^.$'|grep -v '^..$'`

tar -zcvf ETL_Script.tar.gz ETL_Script

mkdir -p ~/package/sssia/��װ��/ETL_Script
cp $buildhome/ETL_Script.tar.gz ~/package/sssia/��װ��/ETL_Script/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0

