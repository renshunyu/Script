#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ -z "$1" ]]; then
  echo "��������"
  exit 1
fi

#svnhome=/home/aiuap/svnproject/program30/program/hiveloader
svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/hiveloader
buildhome=/home/aiuap/svnproject/program30rm/fbissue

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

if [ -d hiveloader ]; then
  rm -fr hiveloader
fi


#rm -rf $buildhome/hiveloader
#if [ $result != '0' ]
#then
#  echo "ɾ������Ŀ¼����"
#  exit 1
#fi


svn checkout $svnhome 
cd hiveloader
result=$?
if [ $result != '0' ]
then
  echo "�л�Ŀ¼����"
  exit 1
fi

mvn clean package -Dmaven.test.skip=true >./build.log
#ant >./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"

mkdir -p ~/package/sssia/��װ��/hiveloader
cp $buildhome/hiveloader/target/*.tar.gz ~/package/sssia/��װ��/hiveloader/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0

