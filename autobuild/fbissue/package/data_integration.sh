#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.3.9
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ -z "$1" ]]; then
  echo "��������"
  exit 1
fi
svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/data_integration
#svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/v04r06c02/data_integration

buildhome=/home/aiuap/svnproject/program30rm/fbissue

svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
rm -rf $buildhome/data_integration
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cd $buildhome/
svn checkout $svnhome
#cp -rf $svnhome $buildhome/data_integration
#result=$?
#if [ $result != '0' ]
#then
#  echo "����Ŀ¼����"
#  exit 1
#fi
#cd data_integration
find data_integration -name .svn|awk '{print "'\''"$0"'\''"}'|xargs rm -rf

tar -zcvf data_integration.tar.gz data_integration

mkdir -p ~/package/sssia/��װ��/kettle
cp data_integration.tar.gz ~/package/sssia/��װ��/kettle/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0

