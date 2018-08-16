#/bin/sh
echo '##########################################################################'
function fPro()
{
  firsttag=`svn log $1 --stop-on-copy -q|grep -v '\-\-\-\-'|awk '{print $1}'|awk -F'r' '{print $2}'|sort -n|awk 'NR==1'`;
  op=`svn log -r$firsttag $1 --stop-on-copy --verbose|grep products|awk -F' '  '{print $4}'|awk -F':'  '{print $1}'` ;
  opo=http://10.1.198.30/svn/UAPPROGRAM$op;
  #echo $opo
  if [ `echo $opo|grep /program/|wc -l` -eq 1 ];then
  echo "$firsttag $opo";
  else
  echo `fPro $opo` ;
  fi
  return 0

}
echo '##########################################################################'


fPro http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/aisiav04r05c00_20180627/iap
fPro "http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/aisiav04r05c00_20180627/data-reporting"
fPro "http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/test/data-reporting"




#exit 1
aiiappath='http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30'

if [ ! -n "$1" ]; then
	reno=aisiav04r04c02_20180509
else
	reno=$1
fi
echo $reno
release=`svn list $aiiappath/release/$reno`

echo '目录：'
biaoti=1
for i in $release
do
echo '	'$biaoti'. '$i
biaoti=$[ biaoti + 1 ]
done
echo
echo
echo
echo '详细：'
biaoti=1
for i in $release
do
	echo $biaoti'. '$i
	rp=$aiiappath/release/$reno/$i
	echo '  '$rp
	or=`fPro $rp|awk '{print $1}'`
	#or=`svn info $aiiappath/release/$reno/$i|awk -F'Last Changed Rev: ' 'NR%10==8{print $2}'`
	echo '  '$or
        sourcepath=`fPro $rp|awk '{print $2}'`
       
	nr=`svn info $aiiappath|awk -F'Last Changed Rev: ' 'NR%10==8{print $2}'`
	echo '  '$nr

	commitnum=`svn log -r$or:$nr $sourcepath|wc -l`
	if [ $commitnum -gt 1 ];then
        	echo '  '主干版本$i有过提交记录
		echo '	'$sourcepath
		svn log -r$or:$nr $sourcepath|awk '{print "	"$0}'
		echo '              ^              '
		echo '              |              '
		echo '              v              '
		echo '  '$aiiappath/release/$reno/$i
		svn log -r$or:$nr $aiiappath/release/$reno/$i|awk '{print "     "$0}'
	else
		echo '  '主干版本$i没有过提交记录
		echo '  '$sourcepath
		svn log -r$or:$nr $sourcepath|awk '{print "     "$0}'
                echo '              ^              '
                echo '              |              '
                echo '              v              '
		echo '  '$aiiappath/release/$reno/$i
		svn log -r$or:$nr $aiiappath/release/$reno/$i|awk '{print "     "$0}'
	fi

 
echo '##########################################################################'
biaoti=$[ biaoti + 1 ]
done
