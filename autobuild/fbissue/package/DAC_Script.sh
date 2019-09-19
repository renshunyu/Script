#!bin/sh
#svnhome=/home/aiuap/svnproject/program30/program/DAC_Script
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ -z "$1" ]]; then
  echo "��������"
  exit 1
fi

buildhome=/home/aiuap/svnproject/program30rm/fbissue
svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/DAC_Script

cd $buildhome
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi

svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi


rm -rf $buildhome/DAC_Script
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi


svn checkout $svnhome
result=$?
if [ $result != '0' ]
then
  echo "ǩ��Ŀ¼����"
  exit 1
fi
#cp -rf $svnhome $buildhome/DAC_Script
#result=$?
##then
 # echo "����Ŀ¼����"
 # exit 1
#fi
rm -fr `find DAC_Script -name '.svn*'|grep -v '^.$'|grep -v '^..$'`

tar -zcvf DAC_Script.tar.gz DAC_Script

mkdir -p ~/package/sssia/��װ��/DAC_Script
cp DAC_Script.tar.gz ~/package/sssia/��װ��/DAC_Script/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0




