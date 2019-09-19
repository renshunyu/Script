#!bin/sh
svnhome=/home/aiuap/svnproject/program30/program/data_integration
buildhome=/home/aiuap/svnproject/program30/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "¸üĞÂsvnÄ¿Â¼´íÎó"
  exit 1
fi
rm -rf $buildhome/data_integration
if [ $result != '0' ]
then
  echo "É¾³ı±àÒëÄ¿Â¼´íÎó"
  exit 1
fi
cp -rf $svnhome $buildhome/data_integration
result=$?
if [ $result != '0' ]
then
  echo "¿½±´Ä¿Â¼´íÎó"
  exit 1
fi
find $buildhome/data_integration -name .svn|awk '{print "'\''"$0"'\''"}'|xargs rm -rf
cd $buildhome/
tar -zcvf data_integration.tar.gz data_integration
