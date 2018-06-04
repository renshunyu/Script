#/bin/sh
echo '##########################################################################'
aiiappath='http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30'

if [ ! -n "$1" ]; then
	reno=aisiav04r04c02_20180509
else
	reno=$1
fi
echo $reno
release=`svn list $aiiappath/release/$reno`

echo 'Ŀ¼��'
biaoti=1
for i in $release
do
echo '	'$biaoti'. '$i
biaoti=$[ biaoti + 1 ]
done
echo
echo
echo
echo '��ϸ��'
biaoti=1
for i in $release
do
	echo $biaoti'. '$i
	rp=$aiiappath/release/$reno/$i
	echo '  '$rp
	or=`svn log $aiiappath/release/$reno/$i --stop-on-copy -q|grep r|awk -F'[r ]' '{print $2}'|sort -n|awk 'NR==1'`
	#or=`svn info $aiiappath/release/$reno/$i|awk -F'Last Changed Rev: ' 'NR%10==8{print $2}'`
	echo '  '$or
        sourcepath=http://10.1.198.30/svn/UAPPROGRAM`svn log -r$or $aiiappath --verbose|grep $reno|awk -F: '{print $1}'|awk '{print $NF}'`
       
	nr=`svn info $aiiappath|awk -F'Last Changed Rev: ' 'NR%10==8{print $2}'`
	echo '  '$nr

	commitnum=`svn log -r$or:$nr $sourcepath|wc -l`
	if [ $commitnum -gt 1 ];then
        	echo '  '���ɰ汾$i�й��ύ��¼
		echo '	'$sourcepath
		svn log -r$or:$nr $sourcepath|awk '{print "	"$0}'
		echo '              ^              '
		echo '              |              '
		echo '              v              '
		echo '  '$aiiappath/release/$reno/$i
		svn log -r$or:$nr $aiiappath/release/$reno/$i|awk '{print "     "$0}'
	else
		echo '  '���ɰ汾$iû�й��ύ��¼
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
