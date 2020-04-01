#/bin/sh
export JAVA_HOME=/usr/java/jdk1.8.0_121
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#if [[ -z $1 || -z $2 || -z $3 ]];then
#  echo ��������3��
#  exit 1
#fi



if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" ]]; then
  echo "�������㣬��Ҫ�ĸ�����"
  exit 1
fi
ISBUILD=$1
VER=$2
SVNTAG=$3
SVNBASE=$4


echo $1
if [ false == $1 ]; then
  echo "ȡ�����"
  exit 0
fi

patchpath=/home/aiuap/svnproject/program30/release/patch/incre
svnurl=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/$2/iap_mysql
spath=/home/aiuap/autobuild/patch/patchs/iapincrepatchmu


svnpath=$svnurl
nv=$SVNTAG
ov=$SVNBASE
buildpath=$patchpath


#mkdir -p ${buildpath}/n/
#mkdir -p ${buildpath}/o/


cd ${buildpath} 
  rm -fr n o
  mkdir -p ${buildpath}/n/
  mkdir -p ${buildpath}/o/

  #ɾ���ϴε�������
  rm -fr $buildpath/iapupdate
  #ɾ�������´���
  mkdir -p $buildpath/iapupdate
  #����ģ�帴��һ��update�ű�
  cp $spath/upmubegin.sh $buildpath/iapupdate/update.sh
  cp $spath/readme.txt $buildpath/iapupdate/readme.txt

  rm -fr $buildpath/iap_mysql
  svn checkout $svnpath
  #svn update ${svnpath} -r${nv} 

  cd iap_mysql



    svn update -r${nv}
    rm -r WebRoot/WEB-INF/classes
    ant |tee build.log
    result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
    if [ $result != '1' ]
    then
      echo "���뱨��"
      exit 1
    fi
    cp target/dist/iap.war ../n


    #svn update ${svnpath} -r${ov} 
    ant clean
    svn update -r${ov}
    rm -r WebRoot/WEB-INF/classes
    ant|tee build.log
    result=`cat build.log|grep -i "BUILD SUCCESSFUL"|wc -l`
    if [ $result != '1' ]
    then
      echo "���뱨��"
      exit 1
    fi
    cp target/dist/iap.war ../o

  cd ..


  cd n
    jar -xvf iap.war
    md5sum `find images jsp prototype scripts style styles WEB-INF -type f|grep -v business.properties|grep -v iap-shanghai.properties|grep -v iap-shanghai-workorder.properties|grep -v client.properties|grep -v elastic.properties |grep -v log4j2.xml|grep -v log4j.properties` >../n.txt

  cd ..

  cd o
    jar -xvf iap.war
    md5sum `find images jsp prototype scripts style styles WEB-INF -type f|grep -v business.properties|grep -v iap-shanghai.properties|grep -v iap-shanghai-workorder.properties|grep -v client.properties|grep -v elastic.properties |grep -v log4j2.xml|grep -v log4j.properties` >../o.txt

  cd ..

  awk 'ARGIND==1{a[$0]=$2;next}{if (!($0 in a)){print "rm -f \$\{iapdir\}/'\''"$2"'\''\nresult \$?"}}' n.txt o.txt >> $buildpath/iapupdate/update.sh 
  echo ===============================================================
  awk 'ARGIND==1{a[$0]=$2;next}function getpath(fpath){split(fpath,b,"/");str="";for (i=1;i<length(b);i++ ){str= str b[i]"/"}return str}{if (!($0 in a)){print "mkdir -p \$\{iapdir\}/"getpath($2)"\ncp iap/'\''"$2"'\'' \$\{iapdir\}/'\''"$2"'\''\nresult \$?"}}' o.txt n.txt >> $buildpath/iapupdate/update.sh
  cat $spath/upmuend.sh  >>$buildpath/iapupdate/update.sh

  for i in `awk 'ARGIND==1{a[$0]=$2;next}{if (!($0 in a)){print $2}}' o.txt n.txt`
  do
    mkdir -p iapupdate/iap/${i/`echo $i|awk -F'/' '{print $NF}'`/}
    cp n/$i iapupdate/iap/${i/`echo $i|awk -F'/' '{print $NF}'`/} 
    
  done

  mkdir -p ~/patch/$2/��װ��/iap/xxxxx_yyyymmddhhmi/����/
  result=$?
  if [ $result != '0' ]
  then
    echo "����Ŀ¼����"
    exit 1
  fi
  cp -r $buildpath/iapupdate ~/patch/$2/��װ��/iap/xxxxx_yyyymmddhhmi/����/
  result=$?
  if [ $result != '0' ]
  then
    echo "���ư�װ������"
    exit 1
  fi

cd

