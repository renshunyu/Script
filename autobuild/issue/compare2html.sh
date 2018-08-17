#/bin/sh
echo '##########################################################################'
#============
echo '<html>' >duibi.html
echo ' <head>' >>duibi.html
echo '    <title>对比</title>' >>duibi.html
echo '  </head>' >>duibi.html
echo '  <body>' >>duibi.html
echo '    <h1>对比指定版本program和release的提交记录</h1>' >>duibi.html
echo '	<!--***************************************************************************************************************-->' >>duibi.html
echo "    <p>$1</p>" >>duibi.html
echo "    <p>`date`</p>" >>duibi.html
echo '	<!--***************************************************************************************************************-->' >>duibi.html
echo '    <h3>目录：</h3>' >>duibi.html
#============



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
#================
echo "    <p class='index'>$biaoti、$i</p>" >>duibi.html
#================
biaoti=$[ biaoti + 1 ]
done
#exit 0
echo
echo
echo
echo '详细：'
#================
echo '<h3>详细：</h3>' >>duibi.html
#================
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
        iproject=`echo $i|sed "s/\///g"`
	if [ $commitnum -gt 1 ];then
        	echo '  '主干版本$i有过提交记录
                #==================================
                echo "  <p>${biaoti}、<a href=\"javascript:openShutManager('${iproject}detail');\">${iproject}</a><span class= 'detailisupdate'>主干版本$i有过提交记录</span></p>" >>duibi.html
		echo "	<div id=${iproject}detail style=\"display: none;\">" >>duibi.html
                echo "	  <div>" >>duibi.html
                echo "	    <p>svnurl:http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/program/$i</p>" >>duibi.html
                echo "	    <table border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse: collapse;table-layout:fixed;width:715pt'>" >>duibi.html
                echo "	      <tr>" >>duibi.html
                echo "		    <td class=tablehead>svn版本号</td>" >>duibi.html
                echo "		    <td class=tablehead>提交时间</td>" >>duibi.html
                echo "		    <td class=tablehead>提交人</td>" >>duibi.html
                echo "		    <td class=tablehead>提交说明</td>" >>duibi.html
                echo "		  </tr>" >>duibi.html
                #==================================
                echo '	'$sourcepath
		svn log -r$or:$nr $sourcepath|awk '{print "	"$0}'
                #==================================
                svn log -r$or:$nr $sourcepath|grep -v '\-\-\-\-\-\-\-\-\-\-\-\-'|grep -v '^$'|awk -F'|' '{if(NF==4){if(NR!=1){print "</tr>"}print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td>"}else{print "<td class=tablerow>"$0"</td>"}}' >>duibi.html
                if [ `tail -n 1 duibi.html |grep '</tr>'|wc -l` -eq 0 ];then
                  echo "            </tr>" >>duibi.html
                fi
                #==================================
		echo '              ^              '
		echo '              |              '
		echo '              v              '
                #==================================
                echo "	    </table>" >>duibi.html
                echo "	  </div>" >>duibi.html
                echo "	  <div>" >>duibi.html
                echo "	    <p>svnurl:http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/${reno}/${i}</p>" >>duibi.html
                echo "	    <table border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse: collapse;table-layout:fixed;width:715pt'>" >>duibi.html
                echo "	      <tr>" >>duibi.html
                echo "		    <td class=tablehead>svn版本号</td>" >>duibi.html
                echo "		    <td class=tablehead>提交时间</td>" >>duibi.html
                echo "		    <td class=tablehead>提交人</td>" >>duibi.html
                echo "		    <td class=tablehead>提交说明</td>" >>duibi.html
                echo "	  	  </tr>" >>duibi.html
                #==================================
		echo '  '$aiiappath/release/$reno/$i
		svn log -r$or:$nr $aiiappath/release/$reno/$i|awk '{print "     "$0}'
                #==================================
                svn log -r$or:$nr $aiiappath/release/$reno/$i|grep -v '\-\-\-\-\-\-\-\-\-\-\-\-'|grep -v '^$'|awk -F'|' '{if(NF==4){if(NR!=1){print "</tr>"}print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td>"}else{print "<td class=tablerow>"$0"</td>"}}' >>duibi.html
                if [ `tail -n 1 duibi.html |grep '</tr>'|wc -l` -eq 0 ];then
                  echo "            </tr>" >>duibi.html
                fi
                #==================================
	else
		echo '  '主干版本$i没有过提交记录
                #=================================
                echo "  <p>${biaoti}、<a href=\"javascript:openShutManager('${iproject}detail');\">${iproject}</a><span class= 'detailisnotupdate'>主干版本$i没有过提交记录</span></p>" >>duibi.html
                echo "  <div id=${iproject}detail style=\"display: none;\">" >>duibi.html
                echo "    <div>" >>duibi.html
                echo "      <p>svnurl:http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/program/$i</p>" >>duibi.html
                echo "      <table border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse: collapse;table-layout:fixed;width:715pt'>" >>duibi.html
                echo "        <tr>" >>duibi.html
                echo "              <td class=tablehead>svn版本号</td>" >>duibi.html
                echo "              <td class=tablehead>提交时间</td>" >>duibi.html
                echo "              <td class=tablehead>提交人</td>" >>duibi.html
                echo "              <td class=tablehead>提交说明</td>" >>duibi.html
                echo "            </tr>" >>duibi.html
                #=================================
                echo '  '$sourcepath
		svn log -r$or:$nr $sourcepath|awk '{print "     "$0}'
                #=================================
                svn log -r$or:$nr $sourcepath|grep -v '\-\-\-\-\-\-\-\-\-\-\-\-'|grep -v '^$'|awk -F'|' '{if(NF==4){if(NR!=1){print "</tr>"}print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td>"}else{print "<td class=tablerow>"$0"</td>"}}' >>duibi.html
                if [ `tail -n 1 duibi.html |grep '</tr>'|wc -l` -eq 0 ];then
                  echo "            </tr>" >>duibi.html
                fi
                #=================================
                echo '              ^              '
                echo '              |              '
                echo '              v              '
                #==================================
                echo "      </table>" >>duibi.html
                echo "    </div>" >>duibi.html
                echo "    <div>" >>duibi.html
                echo "      <p>svnurl:http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/release/${reno}/${i}</p>" >>duibi.html
                echo "      <table border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse: collapse;table-layout:fixed;width:715pt'>" >>duibi.html
                echo "        <tr>" >>duibi.html
                echo "              <td class=tablehead>svn版本号</td>" >>duibi.html
                echo "              <td class=tablehead>提交时间</td>" >>duibi.html
                echo "              <td class=tablehead>提交人</td>" >>duibi.html
                echo "              <td class=tablehead>提交说明</td>" >>duibi.html
                echo "            </tr>" >>duibi.html
                #==================================
		echo '  '$aiiappath/release/$reno/$i
		svn log -r$or:$nr $aiiappath/release/$reno/$i|awk '{print "     "$0}'
                #==================================
                svn log -r$or:$nr $aiiappath/release/$reno/$i|grep -v '\-\-\-\-\-\-\-\-\-\-\-\-'|grep -v '^$'|awk -F'|' '{if(NF==4){if(NR!=1){print "</tr>"}print "  <tr><td class=tablerow>"$1"</td><td class=tablerow>"$3"</td><td class=tablerow>"$2"</td>"}else{print "<td class=tablerow>"$0"</td>"}}' >>duibi.html
                if [ `tail -n 1 duibi.html |grep '</tr>'|wc -l` -eq 0 ];then
                  echo "            </tr>" >>duibi.html
                fi
                #==================================
	fi
        echo "	    </table>" >>duibi.html
        echo "	  </div>" >>duibi.html
        echo "	</div>" >>duibi.html

 
echo '##########################################################################'
biaoti=$[ biaoti + 1 ]
done
echo "  </body>" >>duibi.html
echo "" >>duibi.html
echo "<style>" >>duibi.html
echo ".index{" >>duibi.html
echo "  line-height:5px;" >>duibi.html
echo "  margin-left:40px" >>duibi.html
echo "  }" >>duibi.html
echo ".detailisupdate{" >>duibi.html
echo "  margin-left:40px;" >>duibi.html
echo "  background-color:#FF8C00" >>duibi.html
echo "  }" >>duibi.html
echo ".detailisnotupdate{" >>duibi.html
echo "  margin-left:40px;" >>duibi.html
echo "  background-color:#00FF00" >>duibi.html
echo "  }" >>duibi.html
echo ".tablehead" >>duibi.html
echo "	{mso-style-parent:style0;" >>duibi.html
echo "	text-align:left;" >>duibi.html
echo "	border:.5pt solid windowtext;" >>duibi.html
echo "	background:#BFBFBF;" >>duibi.html
echo "	mso-pattern:black none;}" >>duibi.html
echo ".tablerow" >>duibi.html
echo "	{mso-style-parent:style0;" >>duibi.html
echo "	text-align:left;" >>duibi.html
echo "	border:.5pt solid windowtext;" >>duibi.html
echo "	background:yellow;" >>duibi.html
echo "	mso-pattern:black none;}" >>duibi.html
echo "</style>" >>duibi.html
echo "<script>" >>duibi.html
echo "function openShutManager(id){" >>duibi.html
echo "  var obj=document.getElementById(id)" >>duibi.html
echo "  if (obj.style.display=='none'){" >>duibi.html
echo "    obj.style.display='block'" >>duibi.html
echo "  }else{" >>duibi.html
echo "    obj.style.display='none'" >>duibi.html
echo "  }" >>duibi.html
echo "}" >>duibi.html
echo "</script>" >>duibi.html
echo "</html>" >>duibi.html

