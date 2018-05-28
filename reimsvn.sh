#/bin/sh
echo '##########################################################################'
aiiappath='http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30'
release=`svn list $aiiappath/release/aisiav04r04c02_20180509`

if [ ! -n $reno ]; then
	reno=$1
else
	reno=aisiav04r04c02_20180509
fi

for i in $release
do
	echo $i
	rp=$aiiappath/release/$reno/$i
	echo $rp
	or=`svn log $aiiappath/release/$reno/$i --stop-on-copy -q|grep r|awk -F'[r ]' '{print $2}'|sort -n|awk 'NR==1'`
	#or=`svn info $aiiappath/release/$reno/$i|awk -F'Last Changed Rev: ' 'NR%10==8{print $2}'`
	echo $or
        #sourcepath=http://10.1.198.30/svn/UAPPROGRAM`svn log -r$or $aiiappath --verbose|grep $reno|awk -F: '{print $1}'|awk '{print $NF}'`
       
	nr=`svn info $aiiappath|awk -F'Last Changed Rev: ' 'NR%10==8{print $2}'`
	echo $nr

	commitnum=`svn log -r$or:$nr $aiiappath/release/$reno/$i|wc -l`
	if [ $commitnum -gt 1 ];then
        	echo $i有过提交记录
		svn log -r$or:$nr $aiiappath/release/$reno/$i
	else
		echo $i没有过提交记录
	fi

 
echo '##########################################################################'

done
