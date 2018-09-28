#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
svnhome=/home/aiuap/svnproject/program30rm/auditManagement
buildhome=/home/aiuap/svnproject/program30rm/builddir
svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "����svnĿ¼����"
  exit 1
fi
rm -rf $buildhome/auditManagement
if [ $result != '0' ]
then
  echo "ɾ������Ŀ¼����"
  exit 1
fi
cp -rf $svnhome $buildhome/auditManagement
result=$?
if [ $result != '0' ]
then
  echo "����Ŀ¼����"
  exit 1
fi

cd $buildhome/auditManagement/mng-client
npm install
result=$?
if [ $result != '0' ]
then
  echo "����node��������"
  exit 1
fi
npm run build
result=$?
if [ $result != '0' ]
then
  echo "ǰ�˹��̱������"
  exit 1
fi
#cp static/* ../viewServer/src/main/resources/static/ -r
cd ../viewServer
mvn package -Dmaven.test.skip=true >./build.log

#ant release >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"
