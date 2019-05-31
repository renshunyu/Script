#!bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export M2_HOME=/usr/java/apache-maven-3.2.5
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

ssa_client=$1
SSAServerSvnhome=/home/aiuap/svnproject/program30/program/SSAServer
SSAServerBuildhome=/home/aiuap/svnproject/program30/builddir/SSAServer
SSACSvnhome=/home/aiuap/svnproject/program30/program/ssac
SSACBuildhome=/home/aiuap/svnproject/program30/builddir/ssac

svn up $SSAServerSvnhome
result=$?
if [ $result != '0' ]
then
  echo "����SSAServerĿ¼����"
  exit 1
fi
rm -rf $SSAServerBuildhome/SSAServer
if [ $result != '0' ]
then
  echo "ɾ��SSAServer����Ŀ¼����"
  exit 1
fi
svn up $SSACSvnhome
if [ $result != '0' ]
then
  echo "����SSACĿ¼����"
  exit 1
fi
rm -rf $SSACBuildhome
if [ $result != '0' ]
then
  echo "ɾ��SSAC����Ŀ¼����"
  exit 1
fi

cp -rf $SSAServerSvnhome $SSAServerBuildhome/SSAServer
if [ $result != '0' ]
then
  echo "����SSAServerĿ¼����"
  exit 1
fi

cp -rf $SSACSvnhome $SSACBuildhome
if [ $result != '0' ]
then
  echo "����SSACĿ¼����"
  exit 1
fi

#cd $SSACBuildhome
#cp -rf $SSACBuildhome/node_modules $SSACBuildhome/ssac/${ssa_client}/
cd $SSACBuildhome/${ssa_client}
npm install
result=$?
if [ $result != '0' ]
then
  echo "����node��������"
  exit 1
fi

cd $SSACBuildhome/${ssa_client}
npm run build
result=$?
if [ $result != '0' ]
then
  echo "ǰ�˹��̱������"
  exit 1
fi
#cp static/* ../viewServer/src/main/resources/static/ -r
cd dist
mkdir static-new
mv index.html static ./static-new/
mv static-new static

cd $SSAServerBuildhome
cp pom.xml ./SSAServer/
cd SSAServer
mvn package -Dmaven.test.skip=true >./build.log
result=`cat build.log|grep -i "BUILD SUCCESS"|wc -l`
if [ $result != '1' ]
then
  echo "���뱨��"
  exit 1
fi
echo "����ɹ�"

cd target
#��ǰ̨�Ž�ȥ�����´��.war
unzip SSAServer.war -d $SSAServerBuildhome/SSAServer/target/SSAServer-new
cp -R $SSACBuildhome/${ssa_client}/dist/static ./SSAServer-new/
cd SSAServer-new
jar -cvfM0 SSAServer.war ./
result=$?
if [ $result != '0' ]
then
  echo "���ʧ�ܣ�"
  exit 1
fi
echo "����ɹ���"
