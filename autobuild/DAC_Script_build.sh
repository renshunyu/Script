#!bin/sh
svnhome=/home/aiuap/svnproject/program30/program/DAC_Script
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "¸üĞÂsvnÄ¿Â¼´íÎó"
  exit 1
fi
rm -rf $buildhome/DAC_Script
if [ $result != '0' ]
then
  echo "É¾³ı±àÒëÄ¿Â¼´íÎó"
  exit 1
fi
cp -rf $svnhome $buildhome/DAC_Script
result=$?
if [ $result != '0' ]
then
  echo "¿½±´Ä¿Â¼´íÎó"
  exit 1
fi
rm -fr `find $buildhome/DAC_Script -name '.svn*'|grep -v '^.$'|grep -v '^..$'`
cd $buildhome/
tar -zcvf DAC_Script.tar.gz DAC_Script
