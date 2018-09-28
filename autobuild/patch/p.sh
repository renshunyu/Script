#/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [[ -z $1 || -z $2 || -z $3 ]];then
  echo 参数不足3个
  exit 1
fi
svnpath=$1
nv=$2
ov=$3
buildpath=/home/aiuap/rensy/build
#mkdir -p ${buildpath}/n/
#mkdir -p ${buildpath}/o/


cd ${buildpath} 
  rm -fr n o
  mkdir -p ${buildpath}/n/
  mkdir -p ${buildpath}/o/

  #svn update ${svnpath} -r${nv} 

  cd iap



    svn update -r${nv}
    ant >build.log
    result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
    if [ $result != '1' ]
    then
      echo "编译报错"
      exit 1
    fi
    cp target/dist/iap.war ../n


    #svn update ${svnpath} -r${ov}  
    svn update -r${ov}
    ant >build.log
    result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
    if [ $result != '1' ]
    then
      echo "编译报错"
      exit 1
    fi
    cp target/dist/iap.war ../o

  cd ..


  cd n
    jar -xvf iap.war
    md5sum `find images jsp prototype scripts style styles WEB-INF -type f|grep -v business.properties|grep -v iap-shanghai.properties|grep -v iap-shanghai-workorder.properties|grep -v client.properties|grep -v elastic.properties |grep -v log4j2.xml|grep -v log4j.properties|grep -v iap-spring-base.xml` >../n.txt

  cd ..

  cd o
    jar -xvf iap.war
    md5sum `find images jsp prototype scripts style styles WEB-INF -type f|grep -v business.properties|grep -v iap-shanghai.properties|grep -v iap-shanghai-workorder.properties|grep -v client.properties|grep -v elastic.properties |grep -v log4j2.xml|grep -v log4j.properties|grep -v iap-spring-base.xml` >../o.txt

  cd ..

  awk 'ARGIND==1{a[$0]=$2;next}{if (!($0 in a)){print "rm -f \$\{iapdir\}/'\''"$2"'\''\nresult \$?"}}' n.txt o.txt
  echo ===============================================================
  awk 'ARGIND==1{a[$0]=$2;next}{if (!($0 in a)){print "cp iap/'\''"$2"'\'' \$\{iapdir\}/'\''"$2"'\''\nresult \$?"}}' o.txt n.txt 

cd

