#!bin/sh
svnhome=/home/aiuap/svnproject/program30/program/ETL_Script
buildhome=/home/aiuap/svnproject/program30/builddir
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
cp -rf $svnhome $buildhome/ETL_Script
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi
rm -fr `find $buildhome/ETL_Script -name '.svn*'|grep -v '^.$'|grep -v '^..$'`
cd $buildhome/
tar -zcvf ETL_Script.tar.gz ETL_Script
